Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTAARV5>; Wed, 1 Jan 2003 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbTAARV5>; Wed, 1 Jan 2003 12:21:57 -0500
Received: from ra.abo.fi ([130.232.213.1]:10707 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S264992AbTAARV4>;
	Wed, 1 Jan 2003 12:21:56 -0500
Date: Wed, 1 Jan 2003 19:30:21 +0200 (EET)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: Jaroslav Kysela <perex@suse.cz>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       <trivial-feedback@rustcorp.com.au>
Subject: Re: [patch, 2.5] opti92x-ad1848 one check_region fixup
In-Reply-To: <Pine.LNX.4.33.0301011730590.500-100000@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.44.0301011923340.17721-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Jaroslav Kysela wrote:

> Your patch is bad. Lowlevel drivers allocate the hardware resources (see
> snd_cs4231_create() or snd_ad1848_create() code), but these functions will
> fail, because you allocate resources in the top-level code. I think that 

ok, true. Rusty, I think you haven't included these opti_* patches 
since they depend on the 
"[patch, 2.5] move snd_legacy_find_free_ioport to opti92x-ad1848.c"
patch; just drop the opti_* stuff if you have.

> it will be sufficient to replace check_region call with request_region and 
> release_resource.

This is exactly what check_region does already :), so there is no 
point in changing it like that.

Marcus



