Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVADQNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVADQNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVADQNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:13:15 -0500
Received: from alog0110.analogic.com ([208.224.220.125]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261723AbVADQL7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:11:59 -0500
Date: Tue, 4 Jan 2005 11:05:30 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Lethalman <lethalman@fyrebird.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Let me know EIP address
In-Reply-To: <41DAB3AA.4010207@fyrebird.net>
Message-ID: <Pine.LNX.4.61.0501041103300.4931@chaos.analogic.com>
References: <41DAB3AA.4010207@fyrebird.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Lethalman wrote:

> I'm trying to get the EIP value from a simple program in C but i don't how to 
> do it. I need it to know the current address position on the code segment.
>
> main() {
>  long *eip;
>  asm("mov %%eip,%0" : "=g"(eip));
>  printf("%p\n", eip);
> }
>
> Unfortunately EIP is not that kind of register :P
> Does anyone know how to get EIP?
>

You get the offset of a label, i.e., "foo:\t movl $foo,%0\n" in the asm 
code.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
