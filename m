Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUHORJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUHORJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUHORJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:09:34 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:63621 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265823AbUHORJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:09:32 -0400
Date: Sun, 15 Aug 2004 19:06:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@fs.tum.de>
cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
In-Reply-To: <20040812191859.GN13377@fs.tum.de>
Message-ID: <Pine.LNX.4.61.0408151803460.12687@scrub.home>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org>
 <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de>
 <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home>
 <20040812191859.GN13377@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Aug 2004, Adrian Bunk wrote:

> <--  snip  -->
> 
> config FW_LOADER
>       tristate "Hotplug firmware loading support"
>       depends on HOTPLUG
> 
> config ATMEL
>       tristate "Atmel at76c50x chipset  802.11b support"
>       depends on NET_RADIO && EXPERIMENTAL
>       select FW_LOADER
>       select CRC32
> 
> <--  snip  -->

The basic idea is to mark FW_LOADER as automatically selected and ATMEL 
would simply depend on it and as soon as ATMEL is selected FW_LOADER is 
selected. It'll work similiar to select, but it will respect dependencies 
(since it uses normal depencencies), it will also be easier to force 
deselection of FW_LOADER by (temporarily) disabling autoselect for it.

bye, Roman
