Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWGYM3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWGYM3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 08:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGYM3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 08:29:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63635 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750807AbWGYM3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 08:29:52 -0400
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device
	corruption
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Trent Piepho <xyzzy@speakeasy.org>, robfitz@273k.net,
       video4linux-list@redhat.com, 76306.1226@compuserve.com,
       fork0@t-online.de, greg@kroah.com, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, v4l-dvb-maintainer@linuxtv.org,
       shemminger@osdl.org
In-Reply-To: <20060725020650.52865543.akpm@osdl.org>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>
	 <20060713050541.GA31257@kroah.com>
	 <20060712222407.d737129c.rdunlap@xenotime.net>
	 <20060712224453.5faeea4a.akpm@osdl.org> <20060715230849.GA3385@localhost>
	 <1153013464.4755.35.camel@praia> <20060724200855.603be3bb.akpm@osdl.org>
	 <Pine.LNX.4.58.0607250054410.18397@shell3.speakeasy.net>
	 <20060725020650.52865543.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 25 Jul 2006 09:28:47 -0300
Message-Id: <1153830528.10875.2.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Em Ter, 2006-07-25 às 02:06 -0700, Andrew Morton escreveu:
> On Tue, 25 Jul 2006 01:42:19 -0700 (PDT)
> Trent Piepho <xyzzy@speakeasy.org> wrote:
> 
> > > Do we expect this will fix the various DVB crashes which people (including
> > > Alex) have reported?
> > 
> > This problem would only appear if VIDEO_V4L1 was turned off.  If it was on,
> > then all the code would agree it was on, and there would be no problems.
> > If the crash is still there when VIDEO_V4L1 = y, then it's not related to
> > this bug.
> > 
> > If VIDEO_V4L1 was turned off, then some drivers (one of which is bttv)
> > would have a different struct video_device than the video core code.  This
> > would break things so completely that it could crash just about anywhere.
> 
> OK, thanks.  Alex had
> 
> # CONFIG_VIDEO_V4L1 is not set
> # CONFIG_VIDEO_V4L1_COMPAT is not set
> CONFIG_VIDEO_V4L2=y
That's explains the bug. 

I'll send this patch, together with several other patches (including
several V4L1 to V4L2 conversions) today to -git.

> 
Cheers, 
Mauro.

