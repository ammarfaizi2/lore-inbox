Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280570AbRKBFxr>; Fri, 2 Nov 2001 00:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280572AbRKBFxh>; Fri, 2 Nov 2001 00:53:37 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:25869 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280570AbRKBFxY>;
	Fri, 2 Nov 2001 00:53:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Robert Lowery <Robert.Lowery@colorbus.com.au>
Subject: Re: Best way to setup 128MB box that can only cache 64MB
Date: Thu, 1 Nov 2001 21:52:49 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <370747DEFD89D2119AFD00C0F017E66150B169@cbus613-server4.colorbus.com.au>
In-Reply-To: <370747DEFD89D2119AFD00C0F017E66150B169@cbus613-server4.colorbus.com.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15zXG6-0008A0-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 1, 2001 20:00, Robert Lowery wrote:
> Hi,
>
> I know most people are now having fun on 2GB+ SMP Mega666 processor systems
> these days ;), But unfortunately, I still only have a Pentium 233MMX system
> as my firewall with 128MB RAM with the Intel 430FX chip which can only
> cache the first 64MB.
>
> There have been lots of discussions over the years on this topic, but I
> could not find any definitive answers. How should I set this box up to get
> the best performance?

I'm curious if zones could be of any benefit in this situation. Could the 
kernel be told to use memory over 64megs only if significant pressure is put 
on the VM, sort of like how we treat the DMA zone now? I suspect this will 
have much lower overhead than using the top 64megs as swap. Any MM gods want 
to comment?

-Ryan
