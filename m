Return-Path: <linux-kernel-owner+w=401wt.eu-S1753595AbXABRfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbXABRfO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 12:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbXABRfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 12:35:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46654 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753595AbXABRfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 12:35:11 -0500
Date: Mon, 1 Jan 2007 09:32:12 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Larry Finger <larry.finger@lwfinger.net>
Cc: Tobin Davis <tdavis@dsl-only.net>, Daniel Drake <dsd@gentoo.org>,
       alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Regression in 2.6.19 and 2.6.20 for snd_hda_intel
Message-ID: <20070101093212.6859f053@freekitty>
In-Reply-To: <459741A1.9020909@lwfinger.net>
References: <45971053.7040609@lwfinger.net>
	<45971F39.4060301@gentoo.org>
	<45972EFD.3010103@lwfinger.net>
	<45973283.7060801@gentoo.org>
	<1167538094.9563.230.camel@localhost>
	<459741A1.9020909@lwfinger.net>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2006 22:50:41 -0600
Larry Finger <larry.finger@lwfinger.net> wrote:

> Tobin Davis wrote:
> > Which alsa patch was this?  I'm not seeing anything in the hg logs for
> > this.  Or is this something from the kernel side?
> 
> It seems to have come from suse. The full commit message is:
> 
> commit a7da6ce564a80952d9c0b210deca5a8cd3474a31
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Wed Sep 6 14:03:14 2006 +0200
> 
>     [ALSA] hda-codec - Add independent headphone volume control
> 
>     This patch addes the support of the independent 'Headphone' volume
>     control to the generic codec parser.  Some codecs (e.g. Conexant)
>     have separate connections to the headphone and the independent amp
>     adjustment is needed.
> 
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>     Signed-off-by: Jaroslav Kysela <perex@suse.cz>
> 
> :100644 100644 dedfc5b... 97e9af1... M  sound/pci/hda/hda_generic.c
> 
> Larry
> 
> 

Just make sure you don't break the headphone jack on some systems.
The headphone jack on the Panasonic T5 didn't work until recent kernels
(probably this was the thing that made it work).

-- 
Stephen Hemminger <shemminger@osdl.org>
