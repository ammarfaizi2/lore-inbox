Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWELOUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWELOUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWELOUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:20:22 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9452 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932090AbWELOUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:20:20 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: Segfault on the i386 enter instruction
Date: Fri, 12 May 2006 17:20:13 +0300
User-Agent: KMail/1.8.2
Cc: "Tomasz Malesinski" <tmal@mimuw.edu.pl>, linux-kernel@vger.kernel.org
References: <20060512131654.GB2994@duch.mimuw.edu.pl> <Pine.LNX.4.61.0605121003450.9012@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0605121003450.9012@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605121720.13820.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 17:07, linux-os (Dick Johnson) wrote:
> > 	.file	"a.c"
> > 	.version	"01.01"
> > gcc2_compiled.:
> > .section	.rodata
> > .LC0:
> > 	.string	"asdf\n"
> > .text
> > 	.align 4
> > .globl main
> > 	.type	 main,@function
> > main:
> > 	enter $10008, $0
> > #	pushl %ebp
> > #	movl %esp,%ebp
> > #	subl $10008,%esp
> > 	addl $-12,%esp
>          ^^^^^^^^^^^^^^____________ WTF
>          adding a negative number is subtracting that positive value.
>          You just subtracted 0xfffffff3 (on a 32-bit machine) from
>          the stack pointer. It damn-well better seg-fault!

No. Try it yourself.
--
vda
