Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWEKTHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWEKTHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 15:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWEKTHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 15:07:12 -0400
Received: from main.gmane.org ([80.91.229.2]:47299 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750720AbWEKTHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 15:07:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: Updated libata PATA patch
Date: Thu, 11 May 2006 21:06:51 +0200
Message-ID: <pan.2006.05.11.19.06.16.407785@free.fr>
References: <1147196676.3172.133.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le Tue, 09 May 2006 18:44:36 +0100, Alan Cox a écrit :

> - Re-enable per device speed setting
> - Fix VIA cable detect bug  (reporter: Mathieu Castet)
> - Fix AMD cable detect bug  (reporter: Sangoi Leonard)
> - Fix CS5535 build (reporter: Meelis Roos)
> - Trap 0 IRQ case
> - Fix IRQ allocation for pata_pcmcia (reporter: Kevin Radloff)
> 
> http://zeniv.linux.org.uk/~alan/IDE
Another bug on pata_via :

in via_do_set_mode "mode" argument is never used and ata_timing_compute
always use adev->pio_mode and never adev->dma_mode.
That should explain why viaideinfo report broken timing.

Matthieu

PS : matthieu have 2 't'

