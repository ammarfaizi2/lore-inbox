Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWDEMPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWDEMPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 08:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWDEMPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 08:15:47 -0400
Received: from mail.gondor.com ([212.117.64.182]:37389 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1751221AbWDEMPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 08:15:47 -0400
Date: Wed, 5 Apr 2006 14:15:38 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ken Moffat <zarniwhoop@ntlworld.com>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Slab corruptions & Re: 2.6.17-rc1: Oops in sound applications
Message-ID: <20060405121537.GA4807@knautsch.gondor.com>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain> <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de> <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de> <20060404231911.GA4862@knautsch.gondor.com> <20060405002846.GA5201@knautsch.gondor.com> <20060405090117.GB4794@knautsch.gondor.com> <s5h1wwcp93l.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h1wwcp93l.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 01:14:54PM +0200, Takashi Iwai wrote:
> Try the patch below.  The change in pcm_native.c may be unnecessary,
> but it's better so.
> If it works, I'll submit the patches with a proper log.

The patch (applied to 2.6.17-rc1) does fix the oops, but sound is still
garbled with twinkle using /dev/dsp. 

About this garbled sound: I call an echo service on my asterisk server,
which just echoes back everything I say. Works well using /dev/dsp with
2.6.16, but with 2.6.17-rc1, even with the patch applied, I hear no echo
at all for ~1s. After that, I hear a strongly distorted echo.

If I change the twinkle settings to use the ALSA native devices instead
of /dev/dsp, everything is fine.

Pure playback, eg. with xmms, is fine with 2.6.17-rc1 using /dev/dsp.

Jan

