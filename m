Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTKLQeZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbTKLQeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:34:25 -0500
Received: from 195-23-16-24.nr.ip.pt ([195.23.16.24]:61861 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S263768AbTKLQeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:34:23 -0500
Message-ID: <3FB2611C.40608@grupopie.com>
Date: Wed, 12 Nov 2003 16:34:36 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Linus Torvalds <torvalds@osdl.org>, Solar Designer <solar@openwall.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre9 ide+XFree+ptrace=Complete hang
References: <Pine.LNX.4.44.0311121421450.31972-100000@gaia.cela.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski wrote:

> ....
> sure now that it wouldn't help - the system is just plain totally 
> and completely dead, even the system bios is likely dead - including the 
> System Management Mode code (likely responsible for lighting up the LED 
> on fn key press/release, which no longer works [although not on every 
> crash]).


It is usually the kernel that togles the leds, except when an application (like 
X) requests that the keyboard be put into RAW mode. In RAW mode it is the 
application that is responsible to for updating the leds. If X hangs, Caps-Lock 
and the like will not make the leds toggle anymore.

You can try to issue a SysRq+R to take the keyboard out of RAW mode into XLATE 
so that the kernel translates the keys and you might be able to toggle leds, 
switch consoles, etc.

-- 
Paulo Marques
www.grupopie.com

