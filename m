Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268968AbUJELAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268968AbUJELAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 07:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268972AbUJELAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 07:00:47 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:65198 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S268968AbUJELAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 07:00:44 -0400
Date: Tue, 5 Oct 2004 12:59:18 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Matthias Bernges <mbernges@rumms.uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.x maybe r8169 (maybe disk related as well)
Message-ID: <20041005105918.GA31831@electric-eye.fr.zoreil.com>
References: <200410050836.i958atFM000889@rumms.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410050836.i958atFM000889@rumms.uni-mannheim.de>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Bernges <mbernges@rumms.uni-mannheim.de> :
[...]
> since I use the Realtek 8169 Network card I get a kernel Oops
> after which the kernel hangs completly.
> I tried Kernel 2.6.6, 2.6.7 and 2.6.8.1. It appears randomly but
> only if the machine has high load and high network traffic.

Can you give 2.6.9-rc3 a try ?

[...]
> >>EIP; c0271498 <SELECT_DRIVE+18/50>   <=====
> 
> >>edi; c15eb220 <pg0+113d220/3fb50000>
> >>esp; c0497f80 <per_cpu__tvec_bases+ec0/1008>
> 
> Code;  c0271498 <SELECT_DRIVE+18/50>
> 00000000 <_EIP>:
> Code;  c0271498 <SELECT_DRIVE+18/50>   <=====
>    0:   8b 46 60                  mov    0x60(%esi),%eax   <=====
> Code;  c027149b <SELECT_DRIVE+1b/50>
>    3:   ba 3c 00 00 00            mov    $0x3c,%edx

Your ata subsytem does not seem happy.

Can you provide:
- a short description of the system;
- the revision of your compiler;
- lspci -vx output;
- /sbin/lsmod output;
- complete dmesg after boot;
- vmstat 1 for a few seconds during network load;
- the content of /proc/interrupts adter a few seconds of network load.

--
Ueimor
