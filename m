Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVBIO7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVBIO7x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 09:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVBIO7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 09:59:53 -0500
Received: from alog0384.analogic.com ([208.224.222.160]:8321 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261829AbVBIO7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 09:59:52 -0500
Date: Wed, 9 Feb 2005 09:59:29 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Deepti Patel <pateldeepti@lycos.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Getting errors in compilation of Hello World!
In-Reply-To: <20050209143629.1B610CA09D@ws7-4.us4.outblaze.com>
Message-ID: <Pine.LNX.4.61.0502090957100.4106@chaos.analogic.com>
References: <20050209143629.1B610CA09D@ws7-4.us4.outblaze.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Deepti Patel wrote:

> Hi all,
> I am new to Linux. I am tring to load a module in kernel of 'Fedora core2'.
> I wrote a simple Hello world program and tring to compile it with Makefile. I tried 3 differnt types of make file but still it is giving me error. I will really appritiate any help.
[SNIPPED..]

Dear future Linux Hacker.
Try this for your Makefile. It works fine.


KDIR	:= /lib/modules/$(shell uname -r)/build
PWD	:= $(shell pwd)
obj-m	:= hello.o
default:
 	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
