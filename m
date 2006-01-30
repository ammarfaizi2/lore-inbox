Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWA3PNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWA3PNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWA3PNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:13:13 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:60871 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932310AbWA3PNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:13:11 -0500
Date: Mon, 30 Jan 2006 16:13:07 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: config order problems
In-Reply-To: <Pine.LNX.4.61.0601301114440.25336@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0601301608390.9696@scrub.home>
References: <Pine.LNX.4.61.0601301114440.25336@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 30 Jan 2006, Jan Engelhardt wrote:

> there is a slight problem with `make config` (oldconfig, silentoldconfig).
> By the time we get to the
> 
>   Netfilter Xtables support (required for ip_tables) 
>   (NETFILTER_XTABLES) [N/m/y/?] (NEW) m
> 
> part, CONFIG_NETFILTER_XT_TARGET_CONNMARK is for example not offered 
> because it depends on IP_NF_MANGLE which can be selected later. It is 
> therefore impossible to select CONNMARK without having to go through config 
> twice. In case of automated scripts, this means that CONNMARK remains 
> unselected unless special actions were taken.

It's of course preferable to present the config options in their logical 
order, but 'make config' can deal with it anyway, at the end it rechecks 
the config and it will restart the section, if it doesn't it's a bug.
I tried it here and it works fine, so if there is a problem I need some 
instruction to reproduce it.

bye, Roman
