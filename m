Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267333AbTALI6h>; Sun, 12 Jan 2003 03:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbTALI6h>; Sun, 12 Jan 2003 03:58:37 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:61878 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267333AbTALI6g>;
	Sun, 12 Jan 2003 03:58:36 -0500
Date: Sun, 12 Jan 2003 10:07:21 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       "Harm v.d. Heijden" <H.v.d.Heijden@phys.tue.nl>
Subject: Re: [PATCH] sl82c105 driver update
Message-ID: <20030112100721.A19168@ucw.cz>
References: <1042302798.525.66.camel@zion.wanadoo.fr> <20030111223231.B21505@flint.arm.linux.org.uk> <1042325055.525.153.camel@zion.wanadoo.fr> <20030111234819.A17524@ucw.cz> <20030112015456.GI9153@nbkurt.casa-etp.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030112015456.GI9153@nbkurt.casa-etp.nl>; from garloff@suse.de on Sun, Jan 12, 2003 at 02:54:56AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 02:54:56AM +0100, Kurt Garloff wrote:

> On Sat, Jan 11, 2003 at 11:48:19PM +0100, Vojtech Pavlik wrote:
> > Correct, and it seems that if you have automatic DMA disabled in the
> > kernel and then use hdparm -d1, this leads to a lot of trouble.
> 
> Ack, that's the problem I reported to you the other day, if I'm not mistaken.
> -d1 -Xwhatever worked, just -d1 not.

Yes, that's it. And after some investigation I did it seems like it's so
by design - without using -Xwhatever the IDE driver 'just enables' DMA,
using the BIOS settings of harddrive and the chipset. At least it is so
in recent 2.4's.

I'll have to ask Alan and Andre what really is the intention.

-- 
Vojtech Pavlik
SuSE Labs
