Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbUKLNqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbUKLNqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 08:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbUKLNqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 08:46:06 -0500
Received: from canuck.infradead.org ([205.233.218.70]:19207 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262534AbUKLNqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 08:46:03 -0500
Subject: Re: [PATCH] Add pci_save_state() to ALSA
From: Arjan van de Ven <arjan@infradead.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Zhu, Yi" <yi.zhu@intel.com>, Martin Josefsson <gandalf@wlug.westbo.se>,
       perex@suse.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <s5hzn1ndwqx.wl@alsa2.suse.de>
References: <3ACA40606221794F80A5670F0AF15F8403BD5836@pdsmsx403>
	 <s5hzn1ndwqx.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1100267140.4096.7.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 12 Nov 2004 14:45:40 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-12 at 14:26 +0100, Takashi Iwai wrote:
> But pci_save_state() is called again after the driver's suspend
> callback is called.  So, the final saved state must be anyway same.

no that changed recently in the upstream kernel.
pci_save_state() is now only called if there is no suspend callback in the driver!

