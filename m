Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUGEVIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUGEVIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 17:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUGEVIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 17:08:38 -0400
Received: from hera.cwi.nl ([192.16.191.8]:44438 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262370AbUGEVIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 17:08:31 -0400
Date: Mon, 5 Jul 2004 23:08:13 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Szakacsits Szabolcs <szaka@sienet.hu>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring HDIO_GETGEO semantics)
Message-ID: <20040705210813.GE29504@apps.cwi.nl>
References: <Pine.LNX.4.21.0407041920480.11076-100000@mlf.linux.rulez.org> <200407051513.48334.bzolnier@elka.pw.edu.pl> <20040705140044.GB24899@wsdw14.win.tue.nl> <200407052105.05585.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407052105.05585.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 09:05:05PM +0200, Bartlomiej Zolnierkiewicz wrote:

> Andries, the question was "What should we do with HDIO_GETGEO breakage?"
> not "Why does somebody need the BIOS geometry?". :-)
> 
> We can fix HDIO_GETGEO to behave like in 2.4 or remove it (preferable),
> current situation is bad.

I don't know precisely why.

Neither of your two proposed actions appeals to me.

Here is an ioctl, and it is used for legitimate purposes
(finding the starting offset of a partition).
You cannot remove it. We can think again in 2.7.
For now, leave the kernel interface constant.

Is there any advantage in going back? I don't think so.
The old situation was broken. People lost all data.

Also "the old situation" is badly defined. The returned value differs
for 2.0, 2.2, 2.4, 2.6.

No. We must go forward.

Now distributions can take care of themselves. They can patch the kernel
as they like, or patch parted as they like, or do any number of other things.
RedHat and SuSE can take their own decisions. With some luck there is a new
parted next week or so that they could offer.

So we can go slowly and quietly, investigate precisely what happens, and why
and how such things can be fixed. I think I understand rather well what is
(was) wrong with parted. Maybe Szaka can teach me about other tools that are
broken. I am confident that we can fix them, maybe in hours rather than days.

As a side result we will have something valuable, namely standard software
that tries to handle BIOS data. Several orders of magnitude more reliable
than our old guesses.

Andries
