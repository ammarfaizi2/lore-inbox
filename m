Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271378AbTHHPaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271401AbTHHPaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:30:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:34834 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S271378AbTHHPaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:30:05 -0400
Date: Fri, 8 Aug 2003 17:30:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: kconfig handling of recursive dependencies could be improved
In-Reply-To: <20030808145758.GZ16091@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0308081716140.714-100000@serv>
References: <20030808145758.GZ16091@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Aug 2003, Adrian Bunk wrote:

> I tried to implement a "select at least one of these options" using the 
> following Kconfig snippet:
> 
> config A
>         bool "a"
> 
> config B
>         bool "b"
> 
> config C
>         bool
>         default y if A=n && B=n
>         select A
>         select B

This sort of dependency would be better handled with another choice 
option, but this is not really 2.6 material.

> Yes, there is a limited recursion, but it's a finite recursion and I 
> don't know of any other way to express this in the current kconfig 
> language.

It's not really possible. You can show a comment if nothing is selected 
and use a reasonable default.

bye, Roman

