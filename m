Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVDDSlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVDDSlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 14:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVDDSll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 14:41:41 -0400
Received: from gate.perex.cz ([82.113.61.162]:61401 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S261326AbVDDSjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 14:39:40 -0400
Date: Mon, 4 Apr 2005 20:39:37 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adrian Bunk <bunk@stusta.de>
Cc: Daniel Drake <dsd@gentoo.org>,
       David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>
Subject: Re: ALSA bugs with 2.6.12-rc1
In-Reply-To: <20050404173453.GB4087@stusta.de>
Message-ID: <Pine.LNX.4.58.0504042034400.1764@pnote.perex-int.cz>
References: <42515358.7020101@blue-labs.org> <4251749B.5060603@gentoo.org>
 <20050404173453.GB4087@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Adrian Bunk wrote:

> On Mon, Apr 04, 2005 at 06:08:43PM +0100, Daniel Drake wrote:
> > David Ford wrote:
> > > It seems that 2.6.12-rc1 introduced an ALSA bug generating an oops for a
> > > null pointer.
> > > 
> > > codec_semaphore: semaphore is not ready [0x1][0x300300]
> > > codec_read 0: semaphore is not ready for register 0x2c
> > > Unable to handle kernel NULL pointer dereference at virtual address
> > > 00000000
> > > 
> > > This happens on multiple machines, 32b and 64bit.  I'll be happy to
> > > provide further information if needed.
> > 
> > This only happens when you mismatch your kernel and alsa-lib versions, e.g.
> > running alsa-lib-1.0.9-rc2 with alsa-1.0.8 in-kernel drivers, or possibly
> > vice-versa.
> 
> Are you saying the userspace interface of the ALSA kernel drivers has 
> incompatible changes between minor versions of ALSA?
> 
> If this is true, that's a serious bug.

Nope, but newer alsa-lib use an ALSA timer API feature which was not well 
debugged. This oops should be fixed in 2.6.12-rc2 and older libraries will 
work with newer kernels as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
