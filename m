Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313184AbSDDOw0>; Thu, 4 Apr 2002 09:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313185AbSDDOwG>; Thu, 4 Apr 2002 09:52:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:28654 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313184AbSDDOwD>; Thu, 4 Apr 2002 09:52:03 -0500
Date: Thu, 4 Apr 2002 16:50:25 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5 patch] hdreg.h must include types.h
In-Reply-To: <3CAC1A49.9040509@evision-ventures.com>
Message-ID: <Pine.NEB.4.44.0204041640550.7845-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Martin Dalecki wrote:

> The proper fix is to add linux/types.h in ide-pnp.c in front
> of linux/hdreg.h inclusion. Nested includes are *nasty*.

Why are they nasty? My impression is that they give you a cleaner API in
the sense that you know that when you need something from e.g.
linux/hdreg.h you can simply include this file without bothering which
other header files are needed by this file. The only problem I'm currently
seeing is that circular dependencies between header files might be a
problem but it shouldn't be too hard to check that there are no circular
dependencies. Are there any other problems I don't see?

TIA
Adrian


