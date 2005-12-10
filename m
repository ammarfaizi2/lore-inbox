Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVLJWQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVLJWQe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 17:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVLJWQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 17:16:34 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:28248 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750905AbVLJWQd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 17:16:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cgbFsBjjEywC7x/l4MZoKy3iXeBkL1nDtwLo1jvJpZUE0MD6hNE06/U9SJVb8TVqG80i/LgHBbAFYdbxWOIXehYTsewQdboUTRXXwwEO8d9V4h84lmUZ76MqORGyUEx1KLhNIStIvZR/8w1IZigRELJae5VGTVWiSdY2oN3SowQ=
Message-ID: <4807377b0512101416t2f3a04c5ua6859ab3d99e8d07@mail.gmail.com>
Date: Sat, 10 Dec 2005 14:16:32 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: ph0x <ph0x@freequest.net>
Subject: Re: PROBLEM: bug in e1000 module causes very high CPU load
Cc: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
In-Reply-To: <20051210114100.QFYF676.mxfep01.bredband.com@ph0x>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051210114100.QFYF676.mxfep01.bredband.com@ph0x>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/05, ph0x <ph0x@freequest.net> wrote:
> [1.] One line summary of the problem: bug in e1000 (ksoftirqd eats all CPU)
> [2.] Full description of the problem/report:
>
> After a while of using the network (uptime is 15 days now..) it suddenly
> goes below expected performance. Even tho the utilization of the network is
> 2-3MiB/s the CPU load gets unrealisticly high (1.0 - 8.0 in l/a) and the
> system is very unresponsive via ssh. When freshly rebooted, I'm able to get
> 18-19MiB/s without noticing any lag on ssh. Files have been transferred by
> FTP and samba, still the same result. Kernel is freshly compiled
> (http://www.ph0x.org/kernel.config, generated today) and I noticed this
> issue with 2.6.11.2 aswell.
>
> eth0 is a D-Link DFL-530TX (via_rhine) and has no problems using the full
> 100Mbit/s, but the Intel PRO/1000S has problems using over 10Mbit/s. It's
> not related to the computer I transfer to/from, because I've got a gigabit
> laptop aswell which can output much traffic without getting this high load.

please send the output of cat /proc/interrupts, I'm worried you have
an issue due to interrupt sharing.  If it does fail again and is still
usable, please send the output of ethtool -d eth0, and ethtool -S
eth0. Also, is there any chance you can try the 6.2.15 driver from
http://prdownloads.sf.net/e1000

do you have a test to reproduce this?

Thanks, Jesse
