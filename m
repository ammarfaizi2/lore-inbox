Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbULMT51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbULMT51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbULMTyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:54:20 -0500
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:16137 "EHLO
	legolas.dynup.net") by vger.kernel.org with ESMTP id S262316AbULMTtS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 14:49:18 -0500
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc3-mm1
Date: Mon, 13 Dec 2004 20:49:11 +0100
User-Agent: KMail/1.7.2
Cc: marado@student.dei.uc.pt, linux-kernel@vger.kernel.org
References: <20041213020319.661b1ad9.akpm@osdl.org> <200412131910.24255.rudmer@legolas.dynup.net> <20041213113336.02a0abfd.akpm@osdl.org>
In-Reply-To: <20041213113336.02a0abfd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412132049.11750.rudmer@legolas.dynup.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 December 2004 20:33, Andrew Morton wrote:
> Rudmer van Dijk <rudmer@legolas.dynup.net> wrote:
> > > OTOH, while I had no problems with the previous mm's or with
> > > 2.6.10-rc3,
> > >
> >  > with -rc3-mm1 kdm has an weird function: with kdm/unstable uptodate
> >  > 4:3.3.1-3 from Debian it just restarts X when it's going to show the
> >  > login/password form, restarting over and over.
> >
> >  saw it too with gdm on Gentoo,
>
> It's probably the ioctl screwup.
>
>
> From: Mikael Pettersson <mikpe@csd.uu.se>
>
> The ioctl-cleanup.patch in 2.6.10-rc3-mm1 broke the file ioctls: FIONREAD
> etc.  These ioctls have inline code for S_ISREG() cases, but should be
> redirected to ->ioctl() for other cases.  ioctl-cleanup.patch removed that
> redirection.
>
> For me, both emacs and X refused to start from a console with ENOTTY
> errors; at least emacs got the ENOTTY from FIONREAD.
>

the patch fixed it, all is working now.

thanks,

 Rudmer
