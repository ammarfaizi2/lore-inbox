Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWGYDKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWGYDKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 23:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWGYDKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 23:10:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932405AbWGYDKh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 23:10:37 -0400
Date: Mon, 24 Jul 2006 20:08:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: robfitz@273k.net, rdunlap@xenotime.net, greg@kroah.com,
       76306.1226@compuserve.com, fork0@t-online.de,
       linux-kernel@vger.kernel.org, shemminger@osdl.org,
       video4linux-list@redhat.com, v4l-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH] V4L: struct video_device corruption
Message-Id: <20060724200855.603be3bb.akpm@osdl.org>
In-Reply-To: <1153013464.4755.35.camel@praia>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>
	<20060713050541.GA31257@kroah.com>
	<20060712222407.d737129c.rdunlap@xenotime.net>
	<20060712224453.5faeea4a.akpm@osdl.org>
	<20060715230849.GA3385@localhost>
	<1153013464.4755.35.camel@praia>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2006 22:31:04 -0300
Mauro Carvalho Chehab <mchehab@infradead.org> wrote:

> Em Sáb, 2006-07-15 às 23:08 +0000, Robert Fitzsimons escreveu:
> > The layout of struct video_device would change depending on whether
> > videodev.h (V4L1) was include or not before v4l2-dev.h, which caused
> > the structure to get corrupted.  
> Hmm... good point! However, I the proper solution would be to trust on
> CONFIG_VIDEO_V4L1_COMPAT or CONFIG_VIDEO_V4L1 instead. it makes no sense
> to keep a pointer to an unsupported callback, when V4L1 is not selected.
> 

So I've lost the plot with all of this.  Does the current git-dvb contain
the desired fixes?

Do we expect this will fix the various DVB crashes which people (including
Alex) have reported?

Thanks.
