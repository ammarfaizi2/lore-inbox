Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSFJSrY>; Mon, 10 Jun 2002 14:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315718AbSFJSrX>; Mon, 10 Jun 2002 14:47:23 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:1221 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S315717AbSFJSrW>; Mon, 10 Jun 2002 14:47:22 -0400
Message-Id: <5.1.0.14.2.20020610114308.09306358@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 10 Jun 2002 11:46:36 -0700
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D048CFD.2090201@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

How about replacing __FUNCTION__ with __func__ ?
GCC 3.x warns that __FUNCTION__ is obsolete and will be removed.
Here is how I did it in Bluetooth code:
         #define BT_DBG(fmt, arg...)  printk(KERN_INFO "%s: " fmt "\n" , 
__func__ , ## arg)
no more warnings from gcc.

Max

>Fix improper usage of __FUNCTION__ in usb code.
>Fix unpleasant results from some code formatting
>editor (propably emacs) in i2c, which broke
>an error message altogether.

