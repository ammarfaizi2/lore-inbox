Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVKKRfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVKKRfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbVKKRfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:35:45 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:1929 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750945AbVKKRfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:35:44 -0500
Date: Fri, 11 Nov 2005 18:34:27 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Matt Mackall <mpm@selenic.com>
cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] misc: Configurable number of supported IDE interfaces
In-Reply-To: <20051111171842.GW11462@waste.org>
Message-ID: <Pine.LNX.4.61.0511111830140.1610@scrub.home>
References: <14.282480653@selenic.com> <15.282480653@selenic.com>
 <58cb370e0511110214i33792f33y1b44410d3006fd5f@mail.gmail.com>
 <20051111171842.GW11462@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 11 Nov 2005, Matt Mackall wrote:

> It's intentional. The current CONFIG_IDE_MAX_HWIFS is a hidden
> variable that sets a per architecture maximum. To the best of my
> knowledge, there's no way to do, say:
> 
>    default 4 if ARCH_FOO
>    default 1 if ARCH_BAR
> 
> ..so I'm stuck with using two config symbols anyway.

Where is the problem? This should work fine.
With the latest kernel you can even use a dynamic range:

config IDE_HWIFS
	int "..."
	range 1 IDE_MAX_HWIFS

bye, Roman
