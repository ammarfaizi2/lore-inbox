Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272949AbTHEWne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272952AbTHEWnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:43:33 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:9636
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S272949AbTHEWnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:43:32 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16176.13066.601441.179810@wombat.chubb.wattle.id.au>
Date: Wed, 6 Aug 2003 08:43:22 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Konold <martin.konold@erfrakon.de>, linux-kernel@vger.kernel.org
Subject: Re: Interactive Usage of 2.6.0.test1 worse than 2.4.21
In-Reply-To: <20030804232654.295c9255.akpm@osdl.org>
References: <200308050704.22684.martin.konold@erfrakon.de>
	<20030804232654.295c9255.akpm@osdl.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Martin Konold <martin.konold@erfrakon.de> wrote:
>> Hi,
>> 
>> when using 2.6.0.test1 on a high end laptop (P-IV 2.2 GHz, 1GB RAM)
>> I notice very significant slowdown in interactive usage compared to
>> 2.4.21.
>> 
>> The difference is most easily seen when switching folders in
>> kmail. While 2.4.21 is instantaneous 2.6.0.test1 shows the clock
>> for about 2-3 seconds.
>> 

I see the same problem, and I'm using XFS.  Booting with
elevator=deadline fixed it for me.  The anticipatory scheduler hurts
if you have a disc optimised for low power consumption, not speed.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
