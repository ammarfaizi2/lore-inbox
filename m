Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTH0GsT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 02:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTH0GsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 02:48:19 -0400
Received: from mxrelay.osnanet.de ([212.95.97.103]:3259 "EHLO
	mxrelay.osnanet.de") by vger.kernel.org with ESMTP id S263172AbTH0GsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 02:48:17 -0400
Message-ID: <3F4C537F.9020408@lilymarleen.de>
Date: Wed, 27 Aug 2003 08:45:19 +0200
From: LGW <large@lilymarleen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030711 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: porting-problem, module snd_echoaudio: Unknown relocation: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm new to this list, and I'm new to kernel coding. But I read the 
introductions about the kernel structures, Makefiles and Modules, so I 
think I know at least a little bit.

I'm trying to port a device driver (snd-echoaudio, which is an 
additional driver for alsa) from 2.4.x kernel (alsa) to 2.6.x.

I *think* it should work the way I've done it, but it's a little bit 
messy as the kernel modules needs some C++ files for the hardware 
access. Additionally, those files need some system libraries (they 
depend on <endian.h>, <time.h> and stuff).

This was no problem with the 2.4-kernel, but I think they way they are 
linked might be the problem here.

Everything compiles and links fine, but when I try to load the module 
(yes, I read the build instructions for 2.5/2.6 modules...) I get this:
Error inserting 'sound/pci/echoaudio/snd-echoaudio.ko': -1 Invalid 
module format

while /var/log/kern.log says:
kernel: module snd_echoaudio: Unknown relocation: 0

I really don't know what to look for anymore, so I decided to ask for 
your help. When I strip the driver from everything except init and exit, 
I can load it, so the general build incantation should be alright...

regards,
  Lars

BTW: the 2.6-kernel improvements are great. Thanks to everyone!!

