Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUJ1N2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUJ1N2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbUJ1N2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:28:39 -0400
Received: from gate.perex.cz ([82.113.61.162]:34227 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S263059AbUJ1N2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:28:38 -0400
Date: Thu, 28 Oct 2004 15:29:34 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Christian <evil@g-house.de>
Cc: alsa-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Oops in 2.6.10-rc1
In-Reply-To: <4180F026.9090302@g-house.de>
Message-ID: <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
References: <4180F026.9090302@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Christian wrote:

>   [<c01fc7b8>] pci_enable_device_bars+0x28/0x40
>   [<c01fc7ef>] pci_enable_device+0x1f/0x40
>   [<e082729d>] snd_ensoniq_create+0x1d/0x480 [snd_ens1371]
>   [<e08469cf>] snd_card_new+0x1cf/0x2c0 [snd]

It's a bit dead-lock, because we cannot help you. It seems that
the pci structure passed to our code is broken. The driver has had
no changes in initialization for a long time.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
