Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbUKIAAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbUKIAAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 19:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUKIAAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 19:00:36 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:31971 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261312AbUKIAAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:00:30 -0500
X-Envelope-From: kraxel@bytesex.org
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
References: <20041107224621.GB5360@magma.epfl.ch>
	<418EB58A.7080309@kolivas.org> <20041108000229.GC5360@magma.epfl.ch>
	<418EB8EB.30405@kolivas.org> <20041108003323.GE5360@magma.epfl.ch>
	<418EBFE5.5080903@kolivas.org>
	<Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net>
	<E1CRGZd-0002ss-00@bigred.inka.de>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 09 Nov 2004 00:45:36 +0100
In-Reply-To: <E1CRGZd-0002ss-00@bigred.inka.de>
Message-ID: <87is8frjkv.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Titz <olaf@bigred.inka.de> writes:

> > I suspect two things:
> > - there is some bug in bttv and similar drivers (DVB) that corrupts memory
> > related with internal mm and vfs structures or does something equally bad,
> > - or maybe PCI bandwitch is overflowed, but I do not think it should
> > happen.
> 
> This (first alternative) sounds related to the problem I had with DVB;
> I got visible corruption of video memory when using xawtv on the DVB
> video device using Xv on a G550.

Thats something completely different and usually caused by the gfx
card not being able to handle the bandwith needed for full video
display.  Result are aborted PCI transfers, which results in the video
being displayed fine on the left side and not being displayed
correctly on the right side of the window.

Usually can be workarounded by using 16 bpp instead of 32 which halves
the video data rate.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
