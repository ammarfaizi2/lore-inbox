Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUHIUpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUHIUpi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUHIUix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:38:53 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:59925 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267209AbUHIUgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:36:40 -0400
Date: Mon, 9 Aug 2004 22:38:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
Message-ID: <20040809203840.GB19748@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <20040809195656.GX26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809195656.GX26174@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 09:56:56PM +0200, Adrian Bunk wrote:
> 
> The contract is easy:
> If you select something, you have to ensure the depenencies of the 
> selected option are met.
> 
> This is simple.
> 
> And most people get it wrong.

No - kconfig gets it wrong.
When selecting a config option kconfig shall secure that
'depends on' are evaluated also for the selected symbol.

Otherwise we will end up in a mintenace nightmare. Just think of how many
places to fix if we add and additional depends on to FW_LOADER.

Roman Zippel added in to:.

	Sam
