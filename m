Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUG0Lsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUG0Lsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 07:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUG0Lsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 07:48:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:6148 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264633AbUG0Lsi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 07:48:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       <linux-kernel@vger.kernel.org>
Subject: Re: SuSE 9.1 NON SMP Linux box and SMP Linux box
Date: Tue, 27 Jul 2004 14:47:50 +0300
X-Mailer: KMail [version 1.4]
References: <4EE0CBA31942E547B99B3D4BFAB34811067825@mail.esn.co.in>
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811067825@mail.esn.co.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200407271447.50388.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 12:35, Srinivas G. wrote:
> Hi,
>
> We developed a device driver for PCI card under SuSe 9.1 with kernel
> version 2.6.5-7.71. It was working fine in the NON SMP environment. It
> was compiled and running fine under NON SMP environment(non SMP linux
> box).
>
> We tried to compile it on SMP Linux box with the same SuSe 9.1 having
> the same kernel version 2.6.5-7.71. We got the following compilation
> errors.
>
> line 897: warning: passing arg 1 of  '_raw_spin_lock' from imcompatible
> pointer type line 1051: error: Invalid type arguement of 'unary *'
                                              ^^^^^^^^^

Please do not retype error messages - cut and paste them instead.

> We have gone through the code at that particular line numbers. In both
> the places we found the spin lock related information only. The lines
> were showed below.
>
> line 897:
> spin_lock_irqsave(&tiDev->genFM[uiSocket].blkqueue->queue_lock,flags);
> line 1051:  spin_lock_init(gDisk->qlock);
>
> What was the mistake? Any help greatly appreciated. Thanks in advance.

Show declarations of structures containing qlock and queue_lock
members.
--
vda
