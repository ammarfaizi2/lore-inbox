Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130754AbRCEXL6>; Mon, 5 Mar 2001 18:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130757AbRCEXLt>; Mon, 5 Mar 2001 18:11:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30384 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130756AbRCEXLe>;
	Mon, 5 Mar 2001 18:11:34 -0500
Date: Mon, 5 Mar 2001 18:11:29 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Sergey Kubushin <ksi@cyberbills.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
In-Reply-To: <20010305235629.A1136@werewolf.able.es>
Message-ID: <Pine.GSO.4.21.0103051809180.27373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Mar 2001, J . A . Magallon wrote:

> 
> On 03.05 Sergey Kubushin wrote:
> > On Mon, 5 Mar 2001, Alexander Viro wrote:
> > 
> > New Adaptec driver does not build. It won't. People, can anyone enlighten me
> > why do we use a user space library for a kernel driver at all?
> > 
> > gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c
> > -o aicasm
> 
> What that line does is to build a tool (aicasm) to generate the ucode that
> is built into the kernel (afaik, it is a kind of assembler from a language
> to AIC sequencer code). That is, the tool uses db1 (as mkdep.c uses glibc)
> but once you have generated the sequencer instructions, that is what is built
> into the kernel, not the tool (aicasm).

Yuck. Build-dependency on libdb-dev is not pretty. What is it used for,
anyway? Assembler in need of libdb. Mind boggleth...
								Cheers,
									Al

