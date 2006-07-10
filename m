Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161364AbWGJHMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161364AbWGJHMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161370AbWGJHMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:12:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1755 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161364AbWGJHMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:12:00 -0400
Subject: Re: 2.6.18-rc1-mm1
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <20060709132400.a7f6e358.akpm@osdl.org>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <200607091928.07179.dominik.karall@gmx.net>
	 <20060709132400.a7f6e358.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 10 Jul 2006 04:11:52 -0300
Message-Id: <1152515512.3490.89.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2006-07-09 às 13:24 -0700, Andrew Morton escreveu:
> On Sun, 9 Jul 2006 19:28:07 +0200
> Dominik Karall <dominik.karall@gmx.net> wrote:
> 
> > On Sunday, 9. July 2006 11:11, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1
> > >8-rc1/2.6.18-rc1-mm1/
> > 
> > There are stil problems with initializing the bt878 chip. I'm not sure 
> > if it is the same bug, but I had problems with all -mm versions since 
> > 2.6.17-mm1
> > Screenshot: 
> > http://stud4.tuwien.ac.at/~e0227135/kernel/060709_190546.jpg
> > 
> 
> Right - this is one of those mysterious crashes deep in sysfs from calling
> code which basically hasn't changed.  Mauro and Greg are vacationing or
> otherwise offline so not much is likely to happen short-term.
I should be returning back from vacations by the end of this week. 

About the errors you are suffering, image is not clean enough to allow
reading the log. There were some changes on -mm that may affect people
with third-party drivers (like, for example, some webcam drivers). This
is due to a change at video_device structure, used to register video
devices. Several third-party drivers just have a copy of videodev.h. So,
those drivers compile using the old struct definition, but tries to
register the device by calling a function that is expecting the newer
struct. Maybe this is your case.
> 
> Is 2.6.18-rc1 OK?
Cheers, 
Mauro.

