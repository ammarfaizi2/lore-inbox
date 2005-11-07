Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVKGUgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVKGUgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbVKGUgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:36:12 -0500
Received: from smtp3.brturbo.com.br ([200.199.201.164]:8589 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S965102AbVKGUgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:36:10 -0500
Subject: Re: [Alsa-devel] Re: +
	v4l-720-alsa-support-for-saa7134-that-should-work-fix.patch added to -mm
	tree
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, rlrevell@joe-job.com,
       alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       nshmyrev@yandex.ru, v4l@cerqueira.org
In-Reply-To: <20051107114843.0a476d90.akpm@osdl.org>
References: <200511060743.jA67hpZa018948@shell0.pdx.osdl.net>
	 <20051106001249.48d3ade0.akpm@osdl.org> <1131301995.13599.5.camel@mindpipe>
	 <1131344803.10094.8.camel@localhost> <1131377615.8383.9.camel@mindpipe>
	 <s5h4q6opi5t.wl%tiwai@suse.de>  <20051107114843.0a476d90.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 07 Nov 2005 18:36:01 -0200
Message-Id: <1131395761.6632.125.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Em Seg, 2005-11-07 às 11:48 -0800, Andrew Morton escreveu:
> Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > OK, a brief review:
> >  > 
> >  >  - Why couldn't you use ALSA's DMA API?
> > 
> >  This is OK, IMO.  Basically, it's up to the driver.
> > 
> > 
> >  >  - The DMA must be stopped and started in the trigger callback, not the
> >  > prepare callback.
> >  > 
> >  >  - If this device lacks a volume control alsa-lib can emulate it in
> >  > software, just create a proper /usr/share/alsa/cards/your_card.conf
> >  > file.
> >  > 
> >  >  - By ALSA convention the acceptable formats, sample rates, etc should
> >  > be directly defined in the snd_pcm_hardware_t structure.
> >  > 
> >  >  - dev->oss needs to go.
> > 
> >  Agreed about the rest.
> 
> Thanks, guys.
> 
> Despite all that, I am inclined to merge this patch into 2.6.15.  Because
> it's in the middle of a 192-patch series and we do need to get the v4l tree
> synced up.
> 
> Mauro, if we do that, do you think the above points can be addressed
> inside the next four weeks or so?
	We are, in fact already working on these. We are about to send you a
newer patch addressing most of the points that Takashi and Lee showed.
	You may apply the patches. If they noticed some weird stuff at the
newer patchset, we will have enough time for fix it.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
Cheers, 
Mauro.

