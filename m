Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbTJGNcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTJGNcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:32:17 -0400
Received: from gemini.smart.net ([205.197.48.109]:28941 "EHLO gemini.smart.net")
	by vger.kernel.org with ESMTP id S262121AbTJGNcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:32:14 -0400
Message-ID: <3F82C05A.71F72E72@smart.net>
Date: Tue, 07 Oct 2003 09:32:10 -0400
From: "Daniel B." <dsb@smart.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18+dsb+smp+ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA errors, massive disk corruption: Why? Fixed Yet? Why not 
 re-do failed op?
References: <785F348679A4D5119A0C009027DE33C105CDB20A@mcoexc04.mlm.maxtor.com> <3F81CE9A.851806B8@smart.net> <200310062045.h96KjxJP008005@turing-police.cc.vt.edu> <3F81D995.D9C13F33@smart.net> <3F81DE1D.6070304@pobox.com>
	            <3F824E03.C309F2BE@smart.net> <200310070603.h97631Yl011804@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> 
> On Tue, 07 Oct 2003 01:24:19 EDT, "Daniel B." said:
> 
> > So if some command/batch/etc. wasn't acknowledged, why can't the
> > kernel retry the command/batch/etc.?
> 
> The problem is that the disk ack'ed the command when the block went into the
> write cache.  

That's the acknowledgment I'm talking about.


> You *DONT* in general get back another ack when the block
> actually hits the platters.

I know.  I wasn't talking about any acknowledge after actually writing
the data to the medium.

> > Given the serious of disk data corruption, why isn't the Linux kernel
> > more reliable here?  Hasn't this family of IDE problems been around
> > for a couple of years now?
> 
> It's hard for the kernel to be more reliable unless you just disable the write cache.

Again, I'm NOT talking about write-cache problems.  I'm talking about
problems in the communication/handshaking between the kernel and
the drive.


> The biggest reason we don't see more issues like this is that the average MTBF
> really is up in the 100K hours and up range

That reliability figure is for the _drives_.

That figure obviously does not apply to kernel-to-drive communication,
because I've had dozens of DMA-interrupt corruptions in the last two
or so years.



> Yes, this family of problems has been around ever since write caches were
> introduced. 

I'm not talking about problems related to write caches.  I'm talking 
about DMA interrupt problems.  Why do you think I'm talking about
inside-the-black-box write-cache problems?


> It's just taken until now that we've got file system code that's
> rock solid enough 

Rock solid?  Hah!  If file system (and other disk-related) code is so 
solid why did my root partition get screwed so badly it can't boot?  

(Even if it's bad hardware's fault that an interrupt got lost, and 
even if it's unreasonably complicated (or impossible) for the
kernel to retry an unacknowledged command, why didn't the kernel
stop writing to that disk after the first unacknowledged command?)


> that the write cache is a major reliability issue - for the
> longest time, one kernel bug or another has been more of a concern.

It's not "has been"--it is still a problem, in the newest (is .22 
still the newest) released stable kernel.  

Daniel
-- 
Daniel Barclay
dsb@smart.net
