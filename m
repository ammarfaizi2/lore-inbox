Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWAFDgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWAFDgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 22:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWAFDgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 22:36:22 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:7271 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP
	id S1750970AbWAFDgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 22:36:22 -0500
Date: Fri, 6 Jan 2006 05:33:43 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Edgar Toernig <froese@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <20060106041421.31579e69.froese@gmx.de>
Message-ID: <Pine.LNX.4.61.0601060519450.29362@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi>
 <20060106041421.31579e69.froese@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Edgar Toernig wrote:

> Hannu Savolainen wrote:
> >
> > Takashi Iwai wrote:
> > >
> > > - Split of channels to concurrent accesses
> >
> > Could you be more specific with the above isues?
> 
> As I understand it: instead of providing one device with 5.1 capabilities
> provide one device with 3 concurrent stereo users.  Reading the datasheet
> of my AC'97 decoder (a cheap ALC650 connected to an ATIIXP) there is hard-
> ware that supports this[1].
Then this is in no way an API issue. Many OSS drivers (including envy24) 
create separete device files for each input/output channel (or device pair). 
Applications can chose to open the first device file in for all the 
channels or any combination of the devices in mono/stereo/n-channel mode.

All this depends only on the driver implementation. There is nothing API 
related. Any app can open the devices as usual without paying any 
attention on the channel allocation (which is done automatically by the 
driver). xmms (or whatever else consumer app) can open the device and ask 
for stereo access. Equally well a DAB application can open the device and 
ask for full 10 output channels (or anything between 1 and 10). No special 
API features are needed for this.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
