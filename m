Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbUJXSyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbUJXSyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUJXSyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:54:16 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:59520 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261581AbUJXSyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:54:12 -0400
Date: Sun, 24 Oct 2004 20:54:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
cc: Joerg Sommrey <jo175@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Bug? Load avg 2.0 when idle.
In-Reply-To: <200410242045.04901.linux-kernel@borntraeger.net>
Message-ID: <Pine.LNX.4.53.0410242053100.12554@yvahk01.tjqt.qr>
References: <20041024182918.GA12532@sommrey.de> <200410242045.04901.linux-kernel@borntraeger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> there is a load average of 2.0+ even if the box is almost idle. (i.e.
>> "top" shows just one running process: top itself.) Starting two
>> cpu-intensive processes raises the load average to 4.0+.  How can I
>> determine the source for the high load, or is this a bug?
>> I'm running 2.6.9 on a dual-athlon box.
>
>Besides other possibilities, a bug in the kernel could be the cause.
>Please check if any process (one or two) is in uninterruptible sleep.
>(using ps axl the state is D)
>Furthermore, Magic SysRequest+T (alt-print-t) and the dmesg output could
>give some hints.
>If there is nothing suspicious you might try some profiling tool, e.g.
>OProfile.
>
>There was another bug report about a wrap around load average. I dont know
>if both reports are related.

My ¢2: Start the kernel with init=/bin/sash (or some other minimalistic shell),
if the load average is "normal" (i.e. 0.0), then it's probably somewhere in
userspace.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
