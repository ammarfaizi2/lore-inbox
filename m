Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVKOBJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVKOBJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVKOBJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:09:29 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:35494 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751280AbVKOBJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:09:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17273.13602.687203.565440@wombat.chubb.wattle.id.au>
Date: Tue, 15 Nov 2005 12:08:50 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Claudio Scordino <cloud.of.andor@gmail.com>
Cc: "Magnus Naeslund(f)" <mag@fbab.net>,
       "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: [PATCH] getrusage sucks
In-Reply-To: <200511110211.05642.cloud.of.andor@gmail.com>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com>
	<200511110123.29664.cloud.of.andor@gmail.com>
	<4373E69B.6040206@fbab.net>
	<200511110211.05642.cloud.of.andor@gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Claudio" == Claudio Scordino <cloud.of.andor@gmail.com> writes:

>> You need to wrap this with a read_lock(&tasklist_lock) to be safe,
>> I think.
Claudio> Right. Probably this was the meaning also of Hua's
Claudio> mail. Sorry, but I didn't get it immediately.

Claudio> So, what if I do as follows ? Do you see any problem with
Claudio> this solution ?

You should probably restrict the ability to read a process's usage to
a suitably privileged user -- i.e., effective uid same as the task's,
or capable(CAP_SYS_RESOURCE) or maybe capable(CAP_SYS_ADMIN)

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
