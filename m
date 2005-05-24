Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVEXPSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVEXPSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVEXPSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:18:17 -0400
Received: from quark.didntduck.org ([69.55.226.66]:55527 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262091AbVEXPRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:17:51 -0400
Message-ID: <429345D5.7070406@didntduck.org>
Date: Tue, 24 May 2005 11:18:45 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rol@as2917.net
CC: linux-kernel@vger.kernel.org, rol@witbe.net
Subject: Re: Linux and Initrd used to access disk : how does it work ?
References: <200505241356.j4ODuaR07145@tag.witbe.net>
In-Reply-To: <200505241356.j4ODuaR07145@tag.witbe.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Rolland wrote:
> Hello,
> 
> I've been fighting for a few days with binary modules from some manufacturer
> for hardware support of disk controler, and I'm at a point where I need
> some more understanding.
> 
> 1 - My machine contains an Adaptec SATA Raid based on Marvel 88SX60xx
>     so I need to used the aar81xxx binary module,
> 
> 2 - This module is presented as required to access the disk (when 
>     installing a RH kernel, it says that no disk is present unless the
>     module is loaded),
> 
> 3 - When booting the kernel from disk after installation, the module is 
>     loaded so the machine can access the disk...
> 
> ... BUT ... how can the machine /
>  - boot the kernel,
>  - access the initrd image and uncompress it,
>  - read the binary module inside and load it
> BEFORE loading the module itself, if it is mandatory to access the disk.
> 
> And if it is not, then how can I do the installation ?
> 
> I suspect this should be fairly trivial, but I've been thinking about
> for long, and it looks like chicken and egg to me...
> 
> Any help ?

The kernel and initrd images are loaded by the bootloader (grub, lilo, 
etc.), which uses the BIOS to read from the disk.  So as long as your 
controller has BIOS support you should be ok.

--
				Brian Gerst
