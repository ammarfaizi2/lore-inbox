Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S269987AbUJVOTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269987AbUJVOTL (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 22 Oct 2004 10:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269969AbUJVOTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:19:10 -0400
Received: from spool2-90.gatesgroup.hu ([195.56.78.90]:47242 "EHLO
	melkor.bonehunter.rulez.org") by vger.kernel.org with ESMTP
	id S269962AbUJVOP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:15:56 -0400
Subject: Re: Linux 2.6.9-ac3
From: Gergely Nagy <algernon@bonehunter.rulez.org>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Gergely Nagy <algernon@bonehunter.rulez.org>,
        Luc Saillard <luc@saillard.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1098448494.31003.37.camel@gonzales>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
	 <20041022092102.GA16963@sd291.sivit.org>
	 <20041022143036.462742ca.luca.risolia@studio.unibo.it>
	 <1098448494.31003.37.camel@gonzales>
Content-Type: text/plain
Date: Fri, 22 Oct 2004 16:15:51 +0200
Message-Id: <1098454551.15841.20.camel@melkor>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 14:34 +0200, Xavier Bestel wrote:
> Luc Saillard <luc@saillard.org> wrote:
> > On Fri, Oct 22, 2004 at 10:13:35AM +0200, Luca Risolia wrote:
> > > > o       Restore PWC driver                              (Luc Saillard)
> > > 
> > > This driver does decompression in kernel space, which is not
> > > allowed. That part has to be removed from the driver before
> > > asking for the inclusion in the mainline kernel.
> > 
> > I know this problem, but without a user API like ALSA, each driver need to
> > implement the decompression module. When the driver will support v4l2, we can
> > return the compressed stream to the user land. I want a v4l3, which is
> > designed as ALSA does for soundcard, with a API for userland and kernelland.
> 
> Why not use gstreamer as a userland API ? You deliver compressed video
> through v4l2, then write a decompression plugin specific to your
> chipset.

gstreamer might work for your average desktop application, and a
gstreamer plugin for this might be very handy indeed. However, there are
setups where gstreamer is just too bloated, and there's no way I could
squeeze it on the box's filesystem (think in the 8-16Mb range for
available space).

A small decoding library and a gstreamer plugin on top of that would be
the best solution, I think.

However, until there's such a thing, Luc's driver works fine for me and
my employer.

(Also, keep in mind that PWC thingies are pretty common in some circles,
and owners of these devices would like to see a working driver now.
Instead of a perfect one a year from now. Therefore, the driver staging
in the -ac tree is a very good thing, imho.)

-- 
Gergely Nagy

