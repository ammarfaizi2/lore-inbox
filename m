Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbTGCLae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbTGCLae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:30:34 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:32135 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S265063AbTGCLad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:30:33 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O1int 0307021808 for interactivity
Date: Thu, 3 Jul 2003 13:46:04 +0200
User-Agent: KMail/1.5.2
References: <200307021823.56904.kernel@kolivas.org>
In-Reply-To: <200307021823.56904.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Andrew Morton <akpm@digeo.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307031346.04354.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 July 2003 10:23, Con Kolivas wrote:
> This latest patch I'm formally announcing has the base O1int changes so far
> but includes new semantics for freshly started applications so they can
> become interactive very rapidly even during heavy load. This addresses the
> "slow to start new apps" evident in O1int so far.
>
> Please test this one and note given just how rapidly things can become
> interactive it may have regressions in other settings.

Without this patch, audio skips horribly when I drag a large window.  With it, 
audio is skipless during window dragging, so I like this patch, whatever it 
does (maybe you'd like to do a victory lap and re-explain the theory?).  It's 
not perfect: in Mozilla, scrolling through a long page with the mouse still 
causes skipping.

I'm testing this on a AMD K7 1666 (actual) MHz, 512 MB, VIA VTxxx chipset, 
Software is 2.5.73+Gnome+Metacity+ALSA+Zinf.  Video hardware is S3 ProSavage 
K4M266, running in unaccelerated VGA mode, 1280x1024x16.  Yes, I know audio 
skips less if video is accelerated, IDE runs in dma, etc, but that's not a 
real solution to this soft realtime scheduling problem.

Regards,

Daniel

