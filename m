Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWGBExd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWGBExd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 00:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWGBExd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 00:53:33 -0400
Received: from terminus.zytor.com ([192.83.249.54]:51109 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932409AbWGBExc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 00:53:32 -0400
Message-ID: <44A7511E.4040208@zytor.com>
Date: Sat, 01 Jul 2006 21:52:46 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: Sam Ravnborg <sam@ravnborg.org>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined
 reference to `__stack_chk_fail'
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>	 <1151788673.3195.58.camel@laptopd505.fenrus.org>	 <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>	 <1151789342.3195.60.camel@laptopd505.fenrus.org>	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>	 <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com>	 <20060701230635.GA19114@mars.ravnborg.org>	 <44A706C4.7070908@zytor.com> <20060702030121.GA7247@mars.ravnborg.org>	 <44A73790.5030006@zytor.com> <a44ae5cd0607012105g23a22e67ma3fd2bdd7c9352a4@mail.gmail.com>
In-Reply-To: <a44ae5cd0607012105g23a22e67ma3fd2bdd7c9352a4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> 
> CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>                   $(call cc-option, -fno-stack-protector, ) -fno-common
> in Makefile.
> 
> Trying to compile, I get:
> 
> include/asm/system.h: In function '__set_64bit_var':
> include/asm/system.h:209: warning: dereferencing type-punned pointer
> will break strict-aliasing rules

That's because the kernel CFLAGS need to include -fno-strict-aliasing.

	-hpa

