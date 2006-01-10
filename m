Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWAJCeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWAJCeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 21:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWAJCeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 21:34:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:48003 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932282AbWAJCeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 21:34:02 -0500
Date: Mon, 9 Jan 2006 18:37:19 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: 2.6.14.x and weird things with interrupts on smp machines
Message-ID: <20060110023719.GI3335@sorel.sous-sol.org>
References: <200601081931.31686.arekm@pld-linux.org> <200601081949.12566.arekm@pld-linux.org> <200601082122.03555.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601082122.03555.arekm@pld-linux.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arkadiusz Miskiewicz (arekm@pld-linux.org) wrote:
> That patch
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=fe655d3a06488c8a188461bca493e9f23fc8c448;hp=b0b623c3b22d57d6941b200321779d56c4e79e6b
> seems to fix the problem:
> 
> # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>   0:       5580       4005       4004       3100    IO-APIC-edge  timer
>   4:        488         93          3        231    IO-APIC-edge  serial
>   8:          1          0          0          0    IO-APIC-edge  rtc
>   9:          0          0          0          0   IO-APIC-level  acpi
> 169:       2698          0      11062      16885   IO-APIC-level  qla2300
> 177:      63677          0          0          0   IO-APIC-level  eth0
> 185:          6          0      17417          0   IO-APIC-level  eth1
> NMI:      16778      16762      16758      16760
> LOC:      16515      16561      16680      16704
> ERR:          0
> MIS:          0
> 
> Please put in in stable 2.6.14.x since it's quite important bugfix.

Bad timing, you just missed the last 2.6.14.x -stable tree release.
I'll go ahead and queue this up, and if something else critical comes in
the next week we can do one last round, but don't hold your breath ;-)

thanks,
-chris
