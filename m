Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbUDMRGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 13:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbUDMRGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 13:06:30 -0400
Received: from [195.23.16.24] ([195.23.16.24]:5060 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S263626AbUDMRGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 13:06:24 -0400
Message-ID: <407C1D4F.4060706@grupopie.com>
Date: Tue, 13 Apr 2004 18:03:11 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Lalancette <chris.lalancette@gd-ais.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory image save/restore
References: <407C18D0.9010302@gd-ais.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.25.0.2; VDF: 6.25.0.12; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lalancette wrote:

> Hello all,
> 
>    I have been trying to implement some sort of save/restore kernel 
> memory image for the linux kernel (x86 only right now), without much 
> success.  Let me explain the situation:
> 
> I have a hardware device that I can generate interrupts with.  I also 
> have a machine with 512M of memory, and I am passing the kernel the 
> command line mem=256M.  My idea is to generate an interrupt with the 
> hardware device, and then inside of the interrupt handler make a copy of 
> the entire contents of RAM into the unused upper 256M of memory; later 
> on, with another interrupt, I would like to restore that previously 
> saved memory image.  This way we can go "back in time", similar to what 
> software suspend is doing, but without as many constraints (i.e. we have 
> a hardware interrupt to work with, we reserved the same amount of 
> physical memory to use, etc.).  Before I went much further, I figured I 
> would ask if anyone on the list has tried this, and if there are any 
> reasons why this is not possible.

You're assuming that the state of the memory is the *state* of the entire system.

This fails because there is a lot of state information in hardware registers, 
external peripheral devices, etc., etc.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

