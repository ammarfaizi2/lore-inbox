Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSHIKRw>; Fri, 9 Aug 2002 06:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSHIKRw>; Fri, 9 Aug 2002 06:17:52 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:7697 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318223AbSHIKRv>; Fri, 9 Aug 2002 06:17:51 -0400
Date: Fri, 9 Aug 2002 12:21:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Peter Samuelson <peter@cadcamlab.org>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
In-Reply-To: <20020808174227.GE380@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0208091204360.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Aug 2002, Peter Samuelson wrote:

> > Boolean is simple, what about tristate symbols? How does it modify
> > the input range?
>
> !y == n
> !m == n
> !n == y
>
> To me these are the only semantics that make any sense.  Certainly if
> it goes in the kernel it needs to be added to config-language.txt.

I would define !m as m, e.g. it would allow

dep_tristate "" CONFIG_OLD !$CONFIG_NEW
dep_tristate "" CONFIG_NEW !$CONFIG_OLD

This means only a single driver could be build into the kernel, but both
could be compiled as module.
If we had real expression there, your semantics could easily be described
as $CONFIG!=n, but it wouldn't be possible to describe my semantics.

bye, Roman

