Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbUAMObl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 09:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbUAMObl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 09:31:41 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:29886 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264340AbUAMObj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 09:31:39 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: Re: 2.6.1mm2: nforce2 / amd74xx IDE driver doesn't load
Date: Tue, 13 Jan 2004 15:34:53 +0100
User-Agent: KMail/1.5.4
References: <2867040.OKCKYgd4AF@spamfreemail.de> <400329AE.8050304@cyberone.com.au> <3411792.vcVGz9Xbqa@spamfreemail.de>
In-Reply-To: <3411792.vcVGz9Xbqa@spamfreemail.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401131534.53423.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 of January 2004 08:10, Jens Benecke wrote:
> Nick Piggin wrote:
> >>running an up-to-date XFree86 4.3 from Debian unstable, I have a stuck
> >>mouse pointer in X11 every time some application uses 100% CPU. I have
> >>folding@home running in the background at nice 19, which doesn't disturb
> >>anything, but when my machine starts up the following happens: (...)
> >>During this time (20-30sec) the mouse pointer jerks from position to
> >>position about once to twice a second. My X server runs at priority 0,
> >> not -10, as recommended. This has been the case since 2.6.0-test11, but
> >> I have the (subjective) impression that under 2.6.1rc1-mm1 and 2.6.1-mm2
> >> it got worse.
> >
> > mm kernels have a small interactivity change, so it would be good to
> > compare with plain 2.6.1.
> >
> > It is recommended that your X server run at priority 0. The -10
> > priority is recommended when using my interactivity patches. Its all
> > quite confusing.
>
> Hi,
>
> I have found a (perhaps THE) reason why my X is so jerky: the nforce2
> chipset driver (amd74xx) doesn't load, because it "thinks" the BIOS IDE
> ports are disabled - which is definitely not the case

It doesn't load because IDE ports are already controlled by generic IDE code.
Just use CONFIG_BLK_DEV_AMD74XX=y.  I will fix this "BIOS" comment.

--bart

