Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVANKip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVANKip (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 05:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVANKip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 05:38:45 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:51392 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261941AbVANKil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 05:38:41 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16871.39882.69994.86833@wombat.chubb.wattle.id.au>
Date: Fri, 14 Jan 2005 21:15:38 +1100
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Mike Waychison <Michael.Waychison@sun.com>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather than
In-Reply-To: <41DF1F3D.3030006@nortelnetworks.com>
References: <41DE9D10.B33ED5E4@tv-sign.ru>
	<Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
	<1105113998.24187.361.camel@localhost.localdomain>
	<Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org>
	<Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org>
	<41DEF81B.60905@sun.com>
	<41DF1F3D.3030006@nortelnetworks.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Chris" == Chris Friesen <cfriesen@nortelnetworks.com> writes:

Chris> Mike Waychison wrote:
>> This got me to thinking about how you can heuristically optimize
>> away coalescing support and still allow PAGE_SIZE bytes minimum in
>> the effective buffer.

Chris> While coalescing may be a win in some cases, there should also
Chris> be some way to tell the kernel to NOT coalesce, to handle the
Chris> case where you want minimum latency at the cost of some
Chris> throughput.

SysVr4 pipes used to have two modes: a `legacy' mode that coalesced
data, and a `message' mode that preserved message boundaries.  Seems
to me that we could be about to have the latter in Linux...

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*


