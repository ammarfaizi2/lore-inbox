Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966065AbWKTTEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966065AbWKTTEQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966366AbWKTTEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:04:16 -0500
Received: from nlpi001.sbcis.sbc.com ([207.115.36.30]:16044 "EHLO
	nlpi001.sbcis.sbc.com") by vger.kernel.org with ESMTP
	id S966065AbWKTTEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:04:15 -0500
X-ORBL: [67.117.73.34]
Date: Mon, 20 Nov 2006 19:04:04 +0000
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: Siemens sx1: merge framebuffer support
Message-ID: <20061120190404.GD4597@atomide.com>
References: <20061118181607.GA15275@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118181607.GA15275@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [061118 18:16]:
> From: Vladimir Ananiev <vovan888@gmail.com>
> 
> Framebuffer support for Siemens SX1; this is second big patch. (Third
> one will be mixer/sound support). Support is simple / pretty minimal,
> but seems to work okay (and is somehow important for a cell phone :-).

Pushed to linux-omap. I guess you're planning to send the missing
Kconfig + Makefile patch for this?

Also, it would be better to use omap_mcbsp_xmit_word() or
omap_mcsbsp_spi_master_xmit_word_poll() instead of OMAP_MCBSP_WRITE as
it does not do any checking that it worked. The aic23 and tsc2101
audio in linux-omap tree in general has the same problem.

Regards,

Tony
