Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130741AbRCEW5F>; Mon, 5 Mar 2001 17:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130742AbRCEW4z>; Mon, 5 Mar 2001 17:56:55 -0500
Received: from jalon.able.es ([212.97.163.2]:21143 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130741AbRCEW4l>;
	Mon, 5 Mar 2001 17:56:41 -0500
Date: Mon, 5 Mar 2001 23:56:29 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Sergey Kubushin <ksi@cyberbills.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
Message-ID: <20010305235629.A1136@werewolf.able.es>
In-Reply-To: <Pine.GSO.4.21.0103051605490.27373-100000@weyl.math.psu.edu> <Pine.LNX.4.31ksi3.0103051439250.12620-100000@nomad.cyberbills.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.31ksi3.0103051439250.12620-100000@nomad.cyberbills.com>; from ksi@cyberbills.com on Mon, Mar 05, 2001 at 23:43:33 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.05 Sergey Kubushin wrote:
> On Mon, 5 Mar 2001, Alexander Viro wrote:
> 
> New Adaptec driver does not build. It won't. People, can anyone enlighten me
> why do we use a user space library for a kernel driver at all?
> 
> gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c
> -o aicasm

What that line does is to build a tool (aicasm) to generate the ucode that
is built into the kernel (afaik, it is a kind of assembler from a language
to AIC sequencer code). That is, the tool uses db1 (as mkdep.c uses glibc)
but once you have generated the sequencer instructions, that is what is built
into the kernel, not the tool (aicasm).

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac11 #1 SMP Sat Mar 3 22:18:57 CET 2001 i686

