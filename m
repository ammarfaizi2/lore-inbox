Return-Path: <linux-kernel-owner+w=401wt.eu-S964947AbWL1SiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWL1SiJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWL1SiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:38:09 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:44317 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964960AbWL1SiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:38:08 -0500
Date: Thu, 28 Dec 2006 19:36:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Marcelo Tosatti <marcelo@kvack.org>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, olpc-devel@laptop.org
Subject: Re: [PATCH] introduce config option to disable DMA zone on i386
In-Reply-To: <20061228170302.GA4335@dmt>
Message-ID: <Pine.LNX.4.61.0612281933570.23545@yvahk01.tjqt.qr>
References: <20061228170302.GA4335@dmt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 28 2006 15:03, Marcelo Tosatti wrote:
>
>Comments?
>
>+config NO_DMA_ZONE
         ^^^^^^
>+	bool "DMA zone support"
              ^^^
>+	default n
                ^
>+	help
>+	 This disables support for the 16MiB DMA zone. Only enable this 
>+	 option if you are certain that your devices contain no DMA
>+	 addressing limitations.

The naming could be a bit better. If I have
  [*] DMA zone support
it should actually enable the DMA zone, not disable it. Wind it like you
prefer, either
(1) config NO_DMA_ZONE, bool "Disable DMA zone" default n or
(2) config DMA_ZONE, bool "[Enable] DMA zone" default y


	-`J'
-- 
