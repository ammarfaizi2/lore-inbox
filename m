Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWGMWJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWGMWJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbWGMWJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:09:30 -0400
Received: from mail.gmx.net ([213.165.64.21]:39085 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030423AbWGMWJ3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:09:29 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: 2.6.18-rc1-mm1
Date: Fri, 14 Jul 2006 00:10:15 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
References: <20060709021106.9310d4d1.akpm@osdl.org> <20060709132400.a7f6e358.akpm@osdl.org> <1152515512.3490.89.camel@praia>
In-Reply-To: <1152515512.3490.89.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607140010.15459.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 10. July 2006 09:11, Mauro Carvalho Chehab wrote:
> Em Dom, 2006-07-09 às 13:24 -0700, Andrew Morton escreveu:
> > On Sun, 9 Jul 2006 19:28:07 +0200
> >
> > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > On Sunday, 9. July 2006 11:11, Andrew Morton wrote:
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6
> > > >/2.6.1 8-rc1/2.6.18-rc1-mm1/
> > >
> > > There are stil problems with initializing the bt878 chip. I'm
> > > not sure if it is the same bug, but I had problems with all -mm
> > > versions since 2.6.17-mm1
> > > Screenshot:
> > > http://stud4.tuwien.ac.at/~e0227135/kernel/060709_190546.jpg
> >
> > Right - this is one of those mysterious crashes deep in sysfs
> > from calling code which basically hasn't changed.  Mauro and Greg
> > are vacationing or otherwise offline so not much is likely to
> > happen short-term.
>
> I should be returning back from vacations by the end of this week.
>
> About the errors you are suffering, image is not clean enough to
> allow reading the log. There were some changes on -mm that may
> affect people with third-party drivers (like, for example, some
> webcam drivers). This is due to a change at video_device structure,
> used to register video devices. Several third-party drivers just
> have a copy of videodev.h. So, those drivers compile using the old
> struct definition, but tries to register the device by calling a
> function that is expecting the newer struct. Maybe this is your
> case.
>
> > Is 2.6.18-rc1 OK?

It's the same bug with 2.6.18-rc1.

cheers,
dominik
