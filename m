Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbTBHAVv>; Fri, 7 Feb 2003 19:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTBHAVv>; Fri, 7 Feb 2003 19:21:51 -0500
Received: from hera.cwi.nl ([192.16.191.8]:28884 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S266908AbTBHAVu>;
	Fri, 7 Feb 2003 19:21:50 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Feb 2003 01:31:22 +0100 (MET)
Message-Id: <UTC200302080031.h180VMX26435.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, zippel@linux-m68k.org
Subject: Re: [PATCH] kill i_cdev and struct char_device
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Roman Zippel <zippel@linux-m68k.org>

    On Sat, 8 Feb 2003 Andries.Brouwer@cwi.nl wrote:

    > [the whole purpose of struct block_device is to provide the link
    > between a device number and a struct block_device_operations.
    > struct char_device has no such function, indeed, no function at all]

    Why do you think, the same shouldn't be done for char_device?
    You are removing the wrong infrastructure, check how block_dev.c changed 
    between 2.4 and 2.5 and the same still needs to be done for char_dev.c.

Maybe. Maybe not.
I don't think such things will happen before 2.6.
It is very easy to add this code again for 2.7 if desired.
Today it is just a lot of dead code.


Andries

(And for me the question is still open whether we really want
something like struct char_device for 2.7.)


