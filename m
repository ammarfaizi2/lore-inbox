Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUI2Ks2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUI2Ks2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 06:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268304AbUI2Ks2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 06:48:28 -0400
Received: from [195.23.16.24] ([195.23.16.24]:56505 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268305AbUI2KqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 06:46:20 -0400
Message-ID: <415A9276.4060009@grupopie.com>
Date: Wed, 29 Sep 2004 11:46:14 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc4 "Kernel panic: Attempted to kill init!" - after
 	replacing /fadsroot on the Linux NFSserver with the one from Arabella cdr
 om
References: <313680C9A886D511A06000204840E1CF0A6471D6@whq-msgusr-02.pit.comms.marconi.com>
In-Reply-To: <313680C9A886D511A06000204840E1CF0A6471D6@whq-msgusr-02.pit.comms.marconi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.12; VDF: 6.27.0.78; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Povolotsky, Alexander wrote:
> Hi,
> 
> I have built (cross-compiled for ppc 82xx) Linux 2.6.8-rc4 kernel and am
> trying to boot it on PQ2FADS-VR 
> 
> 
>>I am getting: "Kernel panic: Attempted to kill init!" - after replacing
>>/fadsroot (with the BusyBox) on the remote Linux NFS server with the newer
>>one from the new version of the Arabella cdrom. 
> 
> Is it software or hardware (bad memory ?) issue ?

This seems to be more userspace related than kernel related, so this is 
probably the wrong mailing list. Anyway, check that:

  - busybox is statically linked or that you have the necessary 
libraries in the library path. (you can check this with "ldd busybox")

  - busybox is marked executable

  - busybox is compiled for the right processor

  - check that the init= parameter points to the right executable

  - if you have another ppc machine, try a "chroot <dir> busybox" and 
see if it executes or why it doesn't

I hope this helps,

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
