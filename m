Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWGYJHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWGYJHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWGYJHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:07:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751493AbWGYJHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:07:20 -0400
Date: Tue, 25 Jul 2006 02:06:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: mchehab@infradead.org, robfitz@273k.net, video4linux-list@redhat.com,
       76306.1226@compuserve.com, fork0@t-online.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
       v4l-dvb-maintainer@linuxtv.org, shemminger@osdl.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device
 corruption
Message-Id: <20060725020650.52865543.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0607250054410.18397@shell3.speakeasy.net>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>
	<20060713050541.GA31257@kroah.com>
	<20060712222407.d737129c.rdunlap@xenotime.net>
	<20060712224453.5faeea4a.akpm@osdl.org>
	<20060715230849.GA3385@localhost>
	<1153013464.4755.35.camel@praia>
	<20060724200855.603be3bb.akpm@osdl.org>
	<Pine.LNX.4.58.0607250054410.18397@shell3.speakeasy.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 01:42:19 -0700 (PDT)
Trent Piepho <xyzzy@speakeasy.org> wrote:

> > Do we expect this will fix the various DVB crashes which people (including
> > Alex) have reported?
> 
> This problem would only appear if VIDEO_V4L1 was turned off.  If it was on,
> then all the code would agree it was on, and there would be no problems.
> If the crash is still there when VIDEO_V4L1 = y, then it's not related to
> this bug.
> 
> If VIDEO_V4L1 was turned off, then some drivers (one of which is bttv)
> would have a different struct video_device than the video core code.  This
> would break things so completely that it could crash just about anywhere.

OK, thanks.  Alex had

# CONFIG_VIDEO_V4L1 is not set
# CONFIG_VIDEO_V4L1_COMPAT is not set
CONFIG_VIDEO_V4L2=y

