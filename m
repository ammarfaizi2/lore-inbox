Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbUK3IY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUK3IY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 03:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUK3IY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:24:56 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26331 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262019AbUK3IXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:23:20 -0500
Date: Tue, 30 Nov 2004 09:23:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
In-Reply-To: <5AC4B64A-4286-11D9-8639-000393ACC76E@mac.com>
Message-ID: <Pine.LNX.4.53.0411300919500.18635@yvahk01.tjqt.qr>
References: <MDEHLPKNGKAHNMBLJOLKAEFPACAB.davids@webmaster.com>
 <5AC4B64A-4286-11D9-8639-000393ACC76E@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Even timer interrupts are incredibly unpredictable.  Instructions can
>take
>variable times to complete, and all instructions plus some indeterminate
>cache operations and queue flushing must occur before the CPU can
>even begin to service an interrupt.

Well, don't timer interrupts happen every 1/1000 s (unless, of course, cli() is
in effect)?

>Also of note, there are small
>critical
>sections with interrupts disabled scattered all over the kernel and
>scheduler,
>in addition to varying memory latencies, etc. (NOTE: I am not an arch
>expert

In case you mean the RDTSC, it is of course better than the I8042, for
random-aphy.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
