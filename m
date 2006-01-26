Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWAZTXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWAZTXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWAZTXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:23:47 -0500
Received: from styx.suse.cz ([82.119.242.94]:30606 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964835AbWAZTXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:23:46 -0500
Date: Thu, 26 Jan 2006 20:24:09 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126192409.GC10332@suse.cz>
References: <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <20060126175506.GA32972@dspnet.fr.eu.org> <20060126181034.GA9694@suse.cz> <20060126182818.GA44822@dspnet.fr.eu.org> <Pine.LNX.4.61.0601261938180.14581@yvahk01.tjqt.qr> <d120d5000601261107t44320a91hd1cec82f7eebd38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000601261107t44320a91hd1cec82f7eebd38@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 02:07:53PM -0500, Dmitry Torokhov wrote:
> On 1/26/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> > >> Udev interfaces that and can be set up so that it assigns
> > >> /dev/cdrecorder0, 1, ... to evey recorder in the system, implementing
> > >> the userspace interface.
> > >
> > >Problem is, udev doesn't.  Or at least it varies from distribution to
> > >distribution.  For instance recent gentoo creates /dev/cdrom*,
> > >/dev/cdrw*, /dev/dvd*, /dev/dvdrw*.  Fedora core 3 creates
> > >/dev/cdrom*, /dev/cdwriter*, /dev/dvd*, /dev/dvdwriter*.  I guess from
> > >your email that SuSE does /dev/cdrecorder*.  And I'm not able to
> > >guess what fedora core 5, mandrake, debian, slackware and infinite
> > >number of derivatives do.
> >
> 
> The above can be standatrisized (sp?). How is it different from notmal
> filesystem naming layout?
> 
> > Plus you have to think about systems not using udev at all.
> > Cheers, chaos preprogrammed.
> 
> We might want to add a new class in sysfs, except we do not allow a
> device to belong to several classes (we require splittiing it into
> sub-devices which is not entirely correct in case of DVD+-RW which
> should belong to classes CD, DVD, DVD-RW, OTOH maybe it is sane to
> treat it as 3 different sub-devices in one
> physical package).
 
I don't think there is a reason for a new class. Maybe some attributes,
but not a class - they're all the same kind of devices, only plain
CD-ROMs can only write CDs at speed 0 ;).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
