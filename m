Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbVAFRm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVAFRm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVAFRjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:39:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:47291 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262936AbVAFRh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:37:26 -0500
Subject: Re: [Alsa-devel] Re: 2.6.10-mm1: ALSA ac97 compile error with
	CONFIG_PM=n
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark_H_Johnson@raytheon.com, bunk@stusta.de,
       alsa-devel@alsa-project.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
In-Reply-To: <20050105132711.70f74ecc.akpm@osdl.org>
References: <OF5A3BD386.A1A4C579-ON86256F7F.00688E0E@raytheon.com>
	 <s5his6cm1re.wl@alsa2.suse.de>  <20050105132711.70f74ecc.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105024104.24896.219.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 16:30:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-05 at 21:27, Andrew Morton wrote:
> Takashi Iwai <tiwai@suse.de> wrote:
> >
> > The default blocking behavior of OSS devices was changed recently.
> >  When the device is in use, open returns -EBUSY immediately in the
> >  latest version while it was blocked until released in the former
> >  version.
> > 
> 
> whoa.  That's a significant change in user-visible behaviour.  Why was this
> done?

It now emulates the later OSS PCI and other devices not 2.2 OSS. As such
its the right thing to have done for emulation of OSS IMHO. It also
works with more apps several of which hang on opening /dev/dsp0
expecting OSS -EBUSY responses.

