Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUEVMks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUEVMks (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 08:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUEVMkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 08:40:47 -0400
Received: from 213-229-38-18.static.adsl-line.inode.at ([213.229.38.18]:7076
	"HELO home.winischhofer.net") by vger.kernel.org with SMTP
	id S261186AbUEVMko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 08:40:44 -0400
Message-ID: <40AF4A13.4020005@winischhofer.net>
Date: Sat, 22 May 2004 14:39:47 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioctl number 0xF3
References: <40AF42B3.8060107@winischhofer.net> <1085228451.14486.0.camel@laptop.fenrus.com>
In-Reply-To: <1085228451.14486.0.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 2004-05-22 at 14:08, Thomas Winischhofer wrote:
> 
>>I would like to reserve ioctl's 0xF3 00-40 for the SiS framebuffer 
>>device driver (2.4 and 2.6).
>>
>>Any oppositions?
> 
> 
> well you don't say what you want to use it for.... so nobody can see if
> those ioctls should become generic, if they are 32/64 bit safe etc etc.
> Might be a good idea to post the ioctl interface to the list as well.

I intend using them for controlling SiS hardware specific settings like 
switching output devices, checking modes against output devices, 
repositioning TV output, scaling TV output, changing gamma correction, 
tuning video parameters, and the like. The goal is to be able to write a 
program similar to what sisctrl is for X (see my website for details on 
sisctrl).

I have no list yet as I first wanted to know if somebody opposes for 
reasons like 0xf3/0x0-0x40 being used by another driver already. I 
quickly grep-ed but found none.

And rest assured, they will be 32/64 bit safe. Not sure what you mean by 
"ioctl interface" here but have a look at the Matrox framebuffer driver 
which uses some 'n' ioctls for similar stuff (which in that way do not 
apply to the SiS hardware which is why I can't reuse them).

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org
