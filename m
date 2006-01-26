Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWAZTH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWAZTH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWAZTHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:07:55 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:48071 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964828AbWAZTHy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:07:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fbLOrHvNpPbAOrmnwM1E/DTYsU6D7nXJdrC1i9SvxlaC931r69GIEmVhABtCIWLzHGOM1VwYpJOMFVqckhzGBfhFCW4HObhSI5RvL11voAx5+LQRNAjSqxLJ5Fd1TpoiLbb1xxgQWPmOZsLFI+IW8yRrUqKI+hRMj0IYbqM62xg=
Message-ID: <d120d5000601261107t44320a91hd1cec82f7eebd38@mail.gmail.com>
Date: Thu, 26 Jan 2006 14:07:53 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: Olivier Galibert <galibert@pobox.com>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601261938180.14581@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	 <43D7B1E7.nailDFJ9MUZ5G@burner>
	 <20060125230850.GA2137@merlin.emma.line.org>
	 <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
	 <20060126175506.GA32972@dspnet.fr.eu.org>
	 <20060126181034.GA9694@suse.cz>
	 <20060126182818.GA44822@dspnet.fr.eu.org>
	 <Pine.LNX.4.61.0601261938180.14581@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> Udev interfaces that and can be set up so that it assigns
> >> /dev/cdrecorder0, 1, ... to evey recorder in the system, implementing
> >> the userspace interface.
> >
> >Problem is, udev doesn't.  Or at least it varies from distribution to
> >distribution.  For instance recent gentoo creates /dev/cdrom*,
> >/dev/cdrw*, /dev/dvd*, /dev/dvdrw*.  Fedora core 3 creates
> >/dev/cdrom*, /dev/cdwriter*, /dev/dvd*, /dev/dvdwriter*.  I guess from
> >your email that SuSE does /dev/cdrecorder*.  And I'm not able to
> >guess what fedora core 5, mandrake, debian, slackware and infinite
> >number of derivatives do.
>

The above can be standatrisized (sp?). How is it different from notmal
filesystem naming layout?

> Plus you have to think about systems not using udev at all.
> Cheers, chaos preprogrammed.
>

We might want to add a new class in sysfs, except we do not allow a
device to belong to several classes (we require splittiing it into
sub-devices which is not entirely correct in case of DVD+-RW which
should belong to classes CD, DVD, DVD-RW, OTOH maybe it is sane to
treat it as 3 different sub-devices in one
physical package).

--
Dmitry
