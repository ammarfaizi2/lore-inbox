Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286318AbRLTSgT>; Thu, 20 Dec 2001 13:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbRLTSgK>; Thu, 20 Dec 2001 13:36:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21767 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286318AbRLTSgE>; Thu, 20 Dec 2001 13:36:04 -0500
Message-ID: <3C222F84.4060509@zytor.com>
Date: Thu, 20 Dec 2001 10:35:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
In-Reply-To: <200112181605.KAA00820@tomcat.admin.navo.hpc.mil>	<m18zbzwp34.fsf@frodo.biederman.org> <3C205FBC.60307@zytor.com>	<m1zo4fursh.fsf@frodo.biederman.org>	<9vrlef$mat$1@cesium.transmeta.com>	<m1r8pqv1w3.fsf@frodo.biederman.org> <3C218BF3.6010603@zytor.com> <m1n10dvobd.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
> Agreed.  And to completely dispel the myth.  Etherboot has been doing
> something similar for years.  It disables interrupts in 32bit mode so
> it doesn't have quite as much work to do but otherwise it is pretty
> much the same picture.
> 


If you disable interrupts in 32-bit mode a lot of things will not work.


> I finally tracked down the reason why Setup.S is run in real mode,
> instead of being called from protected mode.  And that is in extremely
> hostile environments (like loadlin works in) loading the kernel wrecks
> the firmware callbacks.  So you must do your BIOS calls as a special
> case before you switch to protected mode.


No, it's because it was easier to do it that way -- do all BIOS calls 
once and for all in the early part of the execution of the kernel, and 
then forget about it.

	-hpa


