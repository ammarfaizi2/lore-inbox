Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWBYSZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWBYSZs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 13:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbWBYSZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 13:25:48 -0500
Received: from smtpout.mac.com ([17.250.248.86]:17612 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161044AbWBYSZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 13:25:48 -0500
In-Reply-To: <200602241237.21628.mbuesch@freenet.de>
References: <Pine.LNX.4.61.0602221504120.11432@yvahk01.tjqt.qr> <200602241237.21628.mbuesch@freenet.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BE7AD56A-27CA-465C-A4C6-774E8C074EF0@mac.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mapping to 0x0
Date: Sat, 25 Feb 2006 13:25:33 -0500
To: Michael Buesch <mbuesch@freenet.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 24, 2006, at 06:37:21, Michael Buesch wrote:
> I am playing around with it. I did the attached code. It is a  
> usermode program, which tries to map NULL, and a kernel module,  
> which calls a NULL pointer. The file badcode.bin contains an i386  
> ud2 instruction. When loading the kernel module, while the usermode  
> program is executing, I get the usual NULL pointer dereference oops:

You need to trigger the null pointer dereference from within the  
userspace program that maps NULL.  The reason your test doesn't do  
anything is that it is the insmod tool whose address space gets used,  
as opposed to your nulltest program.

Cheers,
Kyle Moffett

