Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263650AbVCECXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbVCECXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbVCECST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 21:18:19 -0500
Received: from [209.51.143.194] ([209.51.143.194]:11940 "EHLO
	server14.totalchoicehosting.com") by vger.kernel.org with ESMTP
	id S263322AbVCEBpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:45:22 -0500
Date: Fri, 04 Mar 2005 20:45:31 -0500
From: Leonid Petrov <nouser@lpetrov.net>
Reply-To: Leonid Petrov <nouser@lpetrov.net>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: 2.6.11 ps/2 mouse is dead
Message-ID: <42290F3B.nail4KV19CL16@lpetrov.net>
User-Agent: nail 11.6(mod) 9/7/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server14.totalchoicehosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - verizon.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

> On Friday 04 March 2005 00:52, Leonid Petrov wrote:
> I upgraded from 2.6.10 to 2.6.11 using "make oldconfig" and my
> Logitech ps/2 mouse is dead. cat /dev/input/mice shows
> nothing. Nothing suspicios in /var/log/messages
> The same mousce works fine with 2.6.10
>
>
> Does it work with i8042.noacpi kernel boot option?
>

  I've inserted an option i8042.noacpi:

kernel /boot/vmlinuz-2.6.11 ro root=/dev/hda4 rhgb quiet i8042.noacpi

  to my /boot/grub/menu.lst, and, oh miracle, it works. Moreover, this
option fixed the old problem: mouse and keyboard were dead when I enabled
hyperthreading in BIOS. Now it works with hyperthreading. Excellent!
Thank you very much!

> If it helps woudl you mind sending me your dsdt (cat /proc/acpi/dsdt > dsdt.hex)?

Sure. I've put it in http://lpetrov.net/misc/dsdt.hex

Leonid
2005.03.04_20:40:33
