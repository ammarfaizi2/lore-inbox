Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbUKQNAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbUKQNAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbUKQNAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:00:40 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:3817 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262304AbUKQNA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:00:28 -0500
Date: Wed, 17 Nov 2004 13:57:05 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] DEBUG_BUGVERBOSE for i386 (fwd)
In-Reply-To: <20041117113755.GL4943@stusta.de>
Message-ID: <Pine.LNX.4.61.0411171347300.17266@scrub.home>
References: <20041117043228.GH4943@stusta.de> <20041117003032.7fd91c47.akpm@osdl.org>
 <20041117113755.GL4943@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 17 Nov 2004, Adrian Bunk wrote:

> I simply did it as on other architectures.
> 
> Do you want the following?
> 
> config DEBUG_BUGVERBOSE
>         bool "Verbose BUG() reporting (adds 70K)" if EMBEDDED
>         depends on (DEBUG_KERNEL || EMBEDDED=n) && (ARM || ...)
> 	default y

What are you trying to do here? I guess you want something more like this?

config DEBUG_BUGVERBOSE
	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
	depends on ARM || ...
	default y

bye, Roman
