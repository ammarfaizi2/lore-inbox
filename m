Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315883AbSGARSP>; Mon, 1 Jul 2002 13:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315893AbSGARSO>; Mon, 1 Jul 2002 13:18:14 -0400
Received: from h-64-105-34-244.SNVACAID.covad.net ([64.105.34.244]:37505 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315883AbSGARSN>; Mon, 1 Jul 2002 13:18:13 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 1 Jul 2002 10:20:34 -0700
Message-Id: <200207011720.KAA01499@adam.yggdrasil.com>
To: jlnance@intrex.net
Subject: Re: Rusty's module talk at the Kernel Summit
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul  1 10:07:38 PDT 2002, Jim L. Nance wrote;
>On Mon, Jul 01, 2002 at 09:12:56AM -0700, Adam J. Richter wrote:
>>       As an extereme illustration, imagine a module with 4095 bytes
>> of non-init data and 2 bytes of init data.  With the .init section loaded,
>> the module will occupy two pages.  Freeing the .init section will free
>> an entire page, making 4096 bytes available to the system, even though
>> only two bytes were in the .init section.
>
>Surly we can do better and just not generate .init sections for modules
>where the size would be smaller than a page.  Is binutils capable of doing
>this given the proper linker script?

	I wasn't talking specifically about modules smaller than a
page in that paragraph.  I was talking about modules where the non-init
section ends toward the end of a page and appending the init
section would make it end more toward the begining of a (different) page.

	I also wasn't talking about modifying binutils.  binutils
already works fine with the present .text.init, .data.init, etc.
sections used in compiled-in kernel .o files (see include/linux/init.h)
I was talking about leaving some of this enabled for modules, and how
insmod could be changed to support it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
