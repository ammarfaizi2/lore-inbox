Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbUDEOz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 10:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUDEOz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 10:55:58 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:38284
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S262773AbUDEOz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 10:55:56 -0400
Date: Mon, 5 Apr 2004 11:05:41 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Carlos Fernandez Sanz <cfs-lk@nisupu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3com issues in 2.6.5
Message-ID: <20040405110541.B22980@animx.eu.org>
References: <003301c41b18$38ff7f90$1530a8c0@HUSH>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <003301c41b18$38ff7f90$1530a8c0@HUSH>; from Carlos Fernandez Sanz on Mon, Apr 05, 2004 at 04:13:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to track down my problems with my NIC in 2.6.5 (worked fine in
> 2.4.22). The network "works" but very very slow, and ifconfig shows almost
> the same count in the Tx packet and carrier count:
> 
> TX packets:23818 errors:0 dropped:0 overruns:0 carrier:23817
> 
> dmesg for 2.4.22 and 2.6.5 are almost identical, except for the last lines
> in 2.4.22 (vortex_up, etc). There are no (apparently important) different in
> vortex-diag. mii-diag, however, fails to run in 2.6.5 while it works in
> 2.4.22.
> 
>  Dumps follow, in case someone can shed light.
> 
> (BTW: lsmod in 2.4.22 shows the module as busy (used twice, because I have
> two identical NICs, while in 2.6.5 it seems to be unused - I can unload the
> module with both interfaces up, but obviously as soon as I do that they
> dissapear - I assume this is the intended 2.6 behaviour).

Let me ask you, are you noticing slowness sending or receiving?  I'm having
a similar problem (2.4.25 and 2.6.4 is slow).  I had upgraded the machine
and kernel at the same time.  The nic is a 3c905b+mba nic (it netboots). 
Receiving seems fairly quick, but sending seems slow.  My definition of slow
is "not to it's full speed".  I see about 5mb/sec when I transfer files from
that machine (the disk was capable of 26mb/sec on a file, over network it
was about 5mb/sec)  I noticed the nic was sharing an IRQ (12) with the sound
card (not in use at all).

I should downgrade to 2.4.22 to see if I see a difference.  Oddly, I had
this same board in another machine (which was upgraded) using a 3c990 nic
w/o problems (kernel 2.6.x).  However, I didn't often send files at full
speed either.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
