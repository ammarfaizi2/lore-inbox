Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbUKNUo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbUKNUo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 15:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbUKNUo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 15:44:56 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35278 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261349AbUKNUoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 15:44:54 -0500
Date: Sun, 14 Nov 2004 21:44:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sylvain <autofr@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: question about module and undeinfed symbols.
In-Reply-To: <64b1faec04111412021fcbcf3f@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0411142137520.10840@yvahk01.tjqt.qr>
References: <64b1faec04111410421d76b8fa@mail.gmail.com> 
 <Pine.LNX.4.53.0411141948020.30281@yvahk01.tjqt.qr> <64b1faec04111412021fcbcf3f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>A warning appear during kernel compilation, on the line:
>EXPORT_SYMBOL(myFunction):

That should have been a semicolon (;) not a colon (:).

To access a symbol in the "kernel" (i.e. bzImage) from a module, it needs to be
exported via the already-mentioned EXPORT_SYMBOL(). From kernel to kernel,
there is nothing needed.

>warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'

#include <linux/module.h> to get the EXPORT_SYMBOLs and stuff.

>parameter names (without types) in function declaration
>data definition has no type of storage classe
>
>> #include <linux/kernel.h>

I mean, it's not done with ONE include file. Even for simple modules (like
http://linux01.org:2222/f/oops_ko.tbz2) you already need a handful of includes.

And "small" (~400 lines) modules like my kernel-based tty logger interface
already takes 16 lines o' include.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
