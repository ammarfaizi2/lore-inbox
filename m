Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271399AbTHHPQe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271401AbTHHPQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:16:34 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31762 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S271399AbTHHPQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:16:11 -0400
Date: Fri, 8 Aug 2003 17:16:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 bug: kconfig implementation doesn't match the spec
In-Reply-To: <20030808145107.GY16091@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0308081714160.714-100000@serv>
References: <20030808145107.GY16091@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Aug 2003, Adrian Bunk wrote:

> An example:
> 
> config FOO
>         tristate
>         default m
> 
> config BAR
>         tristate
>         default y if !FOO
>         default n
> 
> 
> According to the kconfig spec BAR should be y, but the implementation in
> 2.6.0-mm5 sets BAR to n.

You probably forgot to set MODULES, tristate behaves like bool in this 
case and FOO becomes 'y' and '!FOO' is 'n'.

bye, Roman

