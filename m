Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312269AbSCRJj6>; Mon, 18 Mar 2002 04:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312270AbSCRJjs>; Mon, 18 Mar 2002 04:39:48 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:61196 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312269AbSCRJjf>;
	Mon, 18 Mar 2002 04:39:35 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Andreas Dilger <adilger@clusterfs.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Cleanup port 0x80 use (was: Re: IO delay ...) 
In-Reply-To: Your message of "Mon, 18 Mar 2002 10:18:06 BST."
             <Pine.LNX.4.33.0203180938060.9609-100000@biker.pdb.fsc.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 18 Mar 2002 20:39:18 +1100
Message-ID: <4463.1016444358@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002 10:18:06 +0100 (CET), 
Martin Wilck <Martin.Wilck@fujitsu-siemens.com> wrote:
>On Sun, 17 Mar 2002, Jamie Lokier wrote:
>
>> As long as __SLOW_DOWN_IO_PORT is a simple constant, you can just use
>> this instead:
>>
>>     #define __SLOW_DOWN_IO_ASM	"\noutb %%al,$" #__SLOW_DOWN_IO_PORT
>
>What cpp are you guys using? Mine does stringification (#s) only with
>arguments of function-like macros. However

Recent 2.4 and 2.5 kernels have include/linux/stringify.h.  This should
work.

#define __SLOW_DOWN_IO_ASM	"\noutb %%al,$" __stringify(__SLOW_DOWN_IO_PORT)

