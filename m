Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261662AbSJ2KDT>; Tue, 29 Oct 2002 05:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261729AbSJ2KDT>; Tue, 29 Oct 2002 05:03:19 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:2900 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261662AbSJ2KDR>; Tue, 29 Oct 2002 05:03:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: DevilKin <devilkin-lkml@blindguardian.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.44] Poweroff after warm reboot
Date: Tue, 29 Oct 2002 11:09:33 +0100
User-Agent: KMail/1.4.3
References: <200210291031.11837.devilkin-lkml@blindguardian.org>
In-Reply-To: <200210291031.11837.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210291109.33009.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 October 2002 10:31, DevilKin wrote:
> Hello,
>
> If I reboot my laptop with kernel 2.5.44 (warm reboot), the machine
> reboots, loads the kernel, and then in the middle of the booting process
> powers off.

Hmm... maybe it has something to do with ACPI ? Could you try booting the 
kernel after a warm reboot with ACPI disabled ?

An other thing I can think about is that a driver does odd things due to the 
fact that the hardware isn't reinitialized completely. See dmesg what driver 
comes after that serial driver and disable the serial driver and / or the 
other driver. See if this helps.

Jos

