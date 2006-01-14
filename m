Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWANCz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWANCz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWANCz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:55:29 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:7377 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750770AbWANCz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:55:29 -0500
From: Grant Coady <gcoady@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4: e100 accounting bust for multiple adapters
Date: Sat, 14 Jan 2006 13:55:16 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <53pgs11trhj0f6ik29hk41n4p5fegbft55@4ax.com>
References: <e196s1pj6u4apbjhgdm3imij4a10s6nb87@4ax.com> <4807377b0601101624m1e1eb636q99ae0792b0903c5a@mail.gmail.com> <cln8s1diqmsei30gqo0dbuv1hclgl4m2lu@4ax.com> <4807377b0601112059je92091ch73f3788aeca452ce@mail.gmail.com>
In-Reply-To: <4807377b0601112059je92091ch73f3788aeca452ce@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 20:59:50 -0800, Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:

>> Anyway the solution is simple: modular e100 is borked on 2.4,
>> compiled in is okay.
>
>modular e100 2.X is borked, right? if you have a moment could you try
>the 3.X e100 driver from sourceforge?
>(http://prdownloads.sf.net/e1000) it should work fine on 2.4 and I
>haven't heard any reports of icky stats.

Hi Jesse, 

Couple of compile warnings:
grant@deltree:~/e100-3.5.10/src$ make clean; make CFLAGS_EXTRA=-DE100_NO_NAPI
rm -rf e100.o e100.o e100.o e100.o e100.o e100.7.gz .*cmd .tmp_versions
gcc -DLINUX -D__KERNEL__ -DMODULE -O2 -pipe -Wall -I/lib/modules/2.4.32-hf32.1x/build/include -I. -DMODVERSIONS -DEXPORT_SYMTAB -include /lib/modules/2.4.32-hf32.1x/build/include/linux/modversions.h -DE100_NO_NAPI   -c -o e100.o e100.c
In file included from /lib/modules/2.4.32-hf32.1x/build/include/linux/spinlock.h:6,
                 from /lib/modules/2.4.32-hf32.1x/build/include/linux/module.h:12,
                 from e100.c:138:
/lib/modules/2.4.32-hf32.1x/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.32-hf32.1x/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.32-hf32.1x/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules


**************************************************
** e100.o built for 2.4.32-hf32.1x
** SMP               Disabled
**************************************************

I have e100-3.5.10 up now and the stats now look okay.  Is this 
driver update headed for 2.4 kernel inclusion?

Grant.
