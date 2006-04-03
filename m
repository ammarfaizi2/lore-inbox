Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWDCWgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWDCWgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 18:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWDCWgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 18:36:09 -0400
Received: from sc-outsmtp2.homechoice.co.uk ([81.1.65.36]:24593 "HELO
	sc-outsmtp2.homechoice.co.uk") by vger.kernel.org with SMTP
	id S1751028AbWDCWgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 18:36:08 -0400
Subject: Re: [Alsa-devel] Re: Patch for AICA sound support on SEGA Dreamcast
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Takashi Iwai <tiwai@suse.de>, Paul Mundt <lethal@linux-sh.org>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <s5h1wwea4wq.wl%tiwai@suse.de>
References: <1144075522.11511.20.camel@localhost.localdomain>
	 <s5hvetqac7i.wl%tiwai@suse.de>
	 <1144086510.11511.46.camel@localhost.localdomain>
	 <s5h1wwea4wq.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 23:36:02 +0100
Message-Id: <1144103762.11511.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 20:29 +0200, Takashi Iwai wrote:

> 
> Anyway, you should use dma_wait_for_completion() instead of your
> home-made one.
> 
The dma_wait_for_completion is broken for g2 dma afaics. Paul - would
you concur?

(Unfortunately the dma_residue register in g2 does not stick at 0 when
there is no residue but returns to the size of the completed dma
transfer. Therefore I can really see no alternative but to writing my
own unless Paul has a better idea.)

