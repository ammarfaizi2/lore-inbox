Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbUAaSjb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 13:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUAaSjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 13:39:31 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:37175 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265059AbUAaSja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 13:39:30 -0500
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
References: <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
	<40193A67.7080308@techsource.com>
	<200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
	<4019472D.70604@techsource.com>
	<200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
	<40195AE0.2010006@techsource.com> <401A33CA.4050104@aitel.hist.no>
	<401A8E0E.6090004@techsource.com>
	<Pine.LNX.4.55.0401301812380.10311@jurand.ds.pg.gda.pl>
	<401A9716.3040607@techsource.com>
	<20040130210915.GA4147@hh.idb.hist.no>
	<401ACB54.1060304@techsource.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 31 Jan 2004 10:39:27 -0800
In-Reply-To: <401ACB54.1060304@techsource.com>
Message-ID: <52ptd07yjk.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 Jan 2004 18:39:28.0893 (UTC) FILETIME=[8F1E32D0:01C3E829]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Timothy" == Timothy Miller <miller@techsource.com> writes:

    Timothy> Alright then, how about this: Assuming opencores has a
    Timothy> PCI interface and a DDR memory controller, I could write
    Timothy> a CRT controller.  We can put that into an FPGA and see
    Timothy> what happens.

I suggest propose the following: spend the next few months designing,
writing documents, and starting on the RTL.  In that time PCI Express
(PCI over high-speed serial) motherboards and fairly cheap
next-generation Xilinx Virtex FPGAs with integrated SERDES and a free
PCI Express core from Xilinx should be available.

PCI Express 8X gives you 16 Gb/sec of bandwidth in both directions (32
Gb/sec total) which should be enough to make UMA (ie no memory
attached to the FPGA) palatable.  So your proto board is looking like
it has just power supplies, FPGA, and misc. video junk (ie DAC or
digital flat panel support), so it should be reasonably cheap to
design and fab.  If you really want to, you could look at putting DRAM
(RLDRAM?) down on the board but I don't think it's worth the cost and
complexity.

(By the way, the Virtex FPGAs also have embedded PowerPC 405 cores
that can run at ~400 MHz, which means a a lot of stuff -- exception
paths, etc -- can be done in firmware if you want)

It's still in the thousands of dollars for this proto stage, but the
Virtex should be fast enough to do something pretty interesting.  At
that point either the project takes off and you can look at doing a
full custom chip (I don't think it's worth doing any "rapid chip" of
low-NRE design, since your unit costs will be too high for a
mass-volume graphics chip), or the project dies.

 - Roland
