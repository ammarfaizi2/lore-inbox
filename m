Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVA0Ved@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVA0Ved (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVA0Vec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:34:32 -0500
Received: from innocence-lost.us ([66.93.152.112]:22452 "EHLO
	innocence-lost.net") by vger.kernel.org with ESMTP id S261226AbVA0VeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:34:14 -0500
Date: Thu, 27 Jan 2005 14:33:49 -0700 (MST)
From: jnf <jnf@innocence-lost.us>
To: John Richard Moser <nigelenki@comcast.net>
cc: Arjan van de Ven <arjan@infradead.org>, linux-os@analogic.com,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <41F94B5A.2030301@comcast.net>
Message-ID: <Pine.LNX.4.62.0501271429430.17993@fhozvffvba.vaabprapr-ybfg.arg>
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>
 <41F92721.1030903@comcast.net>  <1106848051.5624.110.camel@laptopd505.fenrus.org>
  <41F92D2B.4090302@comcast.net>  <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
  <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com>
 <1106856178.5624.128.camel@laptopd505.fenrus.org> <41F94B5A.2030301@comcast.net>
X-GPG-PUBLIC_KEY: http://innocence-lost.net/jnf-pubkey.asc
X-GPG-FINGRPRINT: E24B 994F D483 12EF 61D4  A384 1F16 EFD1 E1A7 954C
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Here's self-exploiting code to discover its own return address offset
> and exploit itself.  It'll lend some insight into how this stuff works.
>
> Just a toy.
>

While I understand the point here, doesn't it become a moot point if:
a) the stack is reinitialized randomly on each execution
and
b) you have to execute that code from within the address space in order to
get the address of itself, therefore if you could already execute code,
then you don't really need the address and if you did wouldnt it be much
easier to do a (ia32) movl %esp pushl %esp ?

The point is to stop the code execution in the first place by randomizing
the addresses and making it hard to guess the offset, there are a ton of
ways to write code that can find the stack pointer or find itself, however
if you cannot execute that code then it becomes a moot point.

Of course I am not refering to causing loops and such in .text code to
brute force addresses.

cheers,

jnf
