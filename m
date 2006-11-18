Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756393AbWKRTbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393AbWKRTbI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 14:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756396AbWKRTbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 14:31:08 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:53635 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1756393AbWKRTbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 14:31:05 -0500
Date: Sat, 18 Nov 2006 20:30:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Oleg Verych <olecom@flower.upol.cz>
cc: Folkert van Heusden <folkert@vanheusden.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
In-Reply-To: <20061118023832.GG13827@flower.upol.cz>
Message-ID: <Pine.LNX.4.61.0611182029150.10940@yvahk01.tjqt.qr>
References: <20061118010946.GB31268@vanheusden.com> <slrnelsomr.dd3.olecom@flower.upol.cz>
 <20061118020200.GC31268@vanheusden.com> <20061118020413.GD31268@vanheusden.com>
 <20061118023832.GG13827@flower.upol.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 18 2006 02:38, Oleg Verych wrote:
>On Sat, Nov 18, 2006 at 03:04:13AM +0100, Folkert van Heusden wrote:
>> > > > I found that sometimes processes disappear on some heavily used system
>> > > > of mine without any logging. So I've written a patch against 2.6.18.2
>> > > > which emits logging when a process emits a fatal signal.
>> > > Why not to patch default signal handlers in glibc, to have not only
>> > > stderr, but syslog, or /dev/kmsg copy of fatal messages?
>> > Afaik when a proces gets shot because of a segfault, also the libraries
>> > it used are shot so to say. iirc some of the more fatal signals are
>> > handled directly by the kernel.
>
>Kernel sends signals, no doubt.
>
>Then, who you think prints that "Killed" or "Segmentation fault"
>messages in *stderr*?
>[Hint: libc's default signal handler (man 2 signal).]


Please enlighten us on how you plan to catch the uncatchable SIGKILL.


	-`J'
-- 
