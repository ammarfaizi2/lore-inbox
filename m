Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266877AbUHJA2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266877AbUHJA2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUHJA2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:28:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:54952 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266877AbUHJA2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:28:08 -0400
Date: Tue, 10 Aug 2004 02:24:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
In-Reply-To: <20040809203840.GB19748@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0408100130470.20634@scrub.home>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 9 Aug 2004, Sam Ravnborg wrote:

> No - kconfig gets it wrong.
> When selecting a config option kconfig shall secure that
> 'depends on' are evaluated also for the selected symbol.

Which dependencies? select was more intended to select symbols without a 
prompt (it's dependency would be simply 'n'). The selected symbol can also 
have multiple prompts, how should these dependencies be merged?
The current select is intentionally simple, so the calculation is 
straightforward. Anything more complex I have to completely rethink the 
behaviour between depencies and selects, e.g. something like this:

	A ---selects----> C ---selects----> D
	B --depends on-->   --depends on--> E

If you want to change the behaviour of select how will it change the 
behaviour of the other dependencies and selects?
I have some ideas for that, but I didn't had the time yet to sit down and 
completely think it through and a few other changes are more important.

bye, Roman
