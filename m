Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbUC2Mh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUC2Mg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:36:27 -0500
Received: from mail.cyclades.com ([64.186.161.6]:30366 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262870AbUC2Mfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:35:40 -0500
Date: Mon, 29 Mar 2004 09:19:46 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Willy TARREAU <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4.26] cmpci cleanup
Message-ID: <20040329121945.GA22215@logos.cnet>
References: <20040328042608.GA17969@logos.cnet> <20040328115718.GB24421@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328115718.GB24421@pcw.home.local>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


WIlly,

We have a cmpci update pending and this error is really harmless,
so lets wait on this one.

On Sun, Mar 28, 2004 at 01:57:18PM +0200, Willy TARREAU wrote:
> Hi Marcelo,
> 
> compiling cmpci in 2.4.26-rc1 complains :
> 
> cmpci.c: In function `cm_probe':
> cmpci.c:3308: warning: unused variable `reg_mask'
> 
> Here is the patch. Please apply,
> Willy
> 
> --- ./drivers/sound/cmpci.c.orig	Sun Mar 28 11:19:12 2004
> +++ ./drivers/sound/cmpci.c	Sun Mar 28 11:19:44 2004
> @@ -3305,7 +3305,6 @@
>  	struct cm_state *s;
>  	mm_segment_t fs;
>  	int i, val, ret;
> -	unsigned char reg_mask = 0;
>  	struct {
>  		unsigned short	deviceid;
>  		char		*devicename;
> @@ -3381,6 +3380,7 @@
>  		printk(KERN_ERR "cmpci: io ports %#x-%#x in use\n", s->iomidi, s->iomidi+CM_EXTENT_MIDI-1);
>  		s->iomidi = 0;
>  	    } else {
> +		unsigned char reg_mask = 0;
>  		/* set IO based at 0x330 */
>  		switch (s->iomidi) {
>  		    case 0x330:
> @@ -3415,6 +3415,7 @@
>  		printk(KERN_ERR "cmpci: io ports %#x-%#x in use\n", s->iosynth, s->iosynth+CM_EXTENT_SYNTH-1);
>  		s->iosynth = 0;
>  	    } else {
> +		unsigned char reg_mask = 0;
>  		/* set IO based at 0x388 */
>  		switch (s->iosynth) {
>  		    case 0x388:
