Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUDMQtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbUDMQtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:49:31 -0400
Received: from GD-AIS-15.vaal02.veridian.com ([137.100.126.15]:61911 "EHLO
	lovok.psrw.com") by vger.kernel.org with ESMTP id S263584AbUDMQt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:49:28 -0400
Message-ID: <407C18D0.9010302@gd-ais.com>
Date: Tue, 13 Apr 2004 12:44:00 -0400
From: Chris Lalancette <chris.lalancette@gd-ais.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031031
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory image save/restore
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

    I have been trying to implement some sort of save/restore kernel 
memory image for the linux kernel (x86 only right now), without much 
success.  Let me explain the situation:

I have a hardware device that I can generate interrupts with.  I also 
have a machine with 512M of memory, and I am passing the kernel the 
command line mem=256M.  My idea is to generate an interrupt with the 
hardware device, and then inside of the interrupt handler make a copy of 
the entire contents of RAM into the unused upper 256M of memory; later 
on, with another interrupt, I would like to restore that previously 
saved memory image.  This way we can go "back in time", similar to what 
software suspend is doing, but without as many constraints (i.e. we have 
a hardware interrupt to work with, we reserved the same amount of 
physical memory to use, etc.).  Before I went much further, I figured I 
would ask if anyone on the list has tried this, and if there are any 
reasons why this is not possible.

Thank you,
Chris Lalancette

P.S.  If you respond to the list, please CC me; I am not subscribed

