Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVCNDFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVCNDFr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 22:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVCNDFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 22:05:47 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:13195 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262057AbVCNDFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 22:05:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16948.65442.160356.17579@wombat.chubb.wattle.id.au>
Date: Mon, 14 Mar 2005 14:06:10 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
In-Reply-To: <9e473391050313175229f1a3d0@mail.gmail.com>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	<9e473391050312075548fb0f29@mail.gmail.com>
	<16948.56475.116221.135256@wombat.chubb.wattle.id.au>
	<9e47339105031317193c28cbcf@mail.gmail.com>
	<16948.60419.257853.470644@wombat.chubb.wattle.id.au>
	<9e473391050313175229f1a3d0@mail.gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:

Jon> On Mon, 14 Mar 2005 12:42:27 +1100, Peter Chubb
Jon> <peterc@gelato.unsw.edu.au> wrote:
>> >>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:
>> 
>> >> The scenario I'm thinking about with these patches are things
>> like >> low-latency user-level networking between nodes in a
>> cluster, where >> for good performance even with a kernel driver
>> you don't want to >> share your interrupt line with anything else.

Jon> Instead of making up a new API what about making a library of
Jon> calls that emulates the common entry points used by device
Jon> drivers. The version I did for UML could take the same driver and
Jon> run it in user space or the kernel without changing source
Jon> code. I found this very useful.

The in-kernel device drivers interface is very large --- I want to
start with something a bit simpler.  We do have a compatibility
library, as yet unreleased, that allows the same drivers to run
in-kernel or in user space.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
