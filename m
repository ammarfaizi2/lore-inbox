Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbUBZXvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUBZXvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:51:06 -0500
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:28602 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261299AbUBZXvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:51:00 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16446.34266.601426.78232@wombat.chubb.wattle.id.au>
Date: Fri, 27 Feb 2004 10:48:42 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: Kingsley Cheung <kingsley@aurema.com>, davidm@hpl.hp.com,
       peter@chubb.wattle.id.au, linux-kernel@vger.kernel.org, dan@debian.org
Subject: Re: /proc visibility patch breaks GDB, etc.
In-Reply-To: <20040226151917.404af252.akpm@osdl.org>
References: <16445.37304.155370.819929@wombat.chubb.wattle.id.au>
	<20040225224410.3eb21312.akpm@osdl.org>
	<16446.19305.637880.99704@napali.hpl.hp.com>
	<20040226120959.35b284ff.akpm@osdl.org>
	<20040227085941.A21764@aurema.com>
	<20040226151917.404af252.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Kingsley Cheung <kingsley@aurema.com> wrote:
>>  Am I correct to assume though that the corresponding change in
>> proc_task_lookup() should stay?  The existing behaviour there was
>> that one could do say,
>> 
>> cat /proc/<pid>/task/<tid>/stat, where tid could be any thread and
>> not a part of the thread group pid.

Andrew> That sounds especially broken - let's hope that nobody has
Andrew> started using it (but how did you even discover this?  Code
Andrew> audit?)

Andrew> How's this?

Looks fine to me --- should fix my immediate problems.  But maybe we
*want* (in 2.7?) to deprecate /proc/tid where tid is a thread ID not a
process ID.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*


