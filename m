Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161272AbWJKXGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161272AbWJKXGu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 19:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161273AbWJKXGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 19:06:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:16334 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161272AbWJKXGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 19:06:48 -0400
Date: Wed, 11 Oct 2006 16:01:25 -0700
From: Greg KH <greg@kroah.com>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Greg KH <gregkh@suse.de>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] [patch 06/67] Video: cx24123: fix PLL divisor setup
Message-ID: <20061011230125.GB26135@kroah.com>
References: <20061011204756.642936754@quad.kroah.org> <20061011210353.GG16627@kroah.com> <452D5EF7.80303@linuxtv.org> <20061011212959.GA18006@suse.de> <452D63D4.6050300@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452D63D4.6050300@linuxtv.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 05:36:20PM -0400, Michael Krufky wrote:
> Greg KH wrote:
> > On Wed, Oct 11, 2006 at 05:15:35PM -0400, Michael Krufky wrote:
> >> Greg KH wrote:
> >>> -stable review patch.  If anyone has any objections, please let us know.
> >>>
> >>> ------------------
> >>> From: Yeasah Pell <yeasah@schwide.net>
> >>>
> >>> The cx24109 datasheet says: "NOTE: if A=0, then N=N+1"
> >>>
> >>> The current code is the result of a misinterpretation of the datasheet to
> >>> mean exactly the opposite of the requirement -- The actual value of N is 1
> >>> greater than the value written when A is 0, so 1 needs to be *subtracted*
> >>> from it to compensate.
> >>>
> >>> Signed-off-by: Yeasah Pell <yeasah@schwide.net>
> >>> Signed-off-by: Steven Toth <stoth@hauppauge.com>
> >>> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> >>> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> >> Greg,
> >>
> >> When you apply this patch to your 2.6.18.y tree (and also to your
> >> 2.6.17.y tree) , can you please preceed the patch title with 'DVB'
> >> instead of 'VIDEO' ?
> >>
> >> I'll be sure to specify the subsystem, instead of only the driver name
> >> in future patches.
> > 
> > Yes, it's better for you to specifiy it, instead of having me guess at
> > what it should be classified as :)
> > 
> > I'll try to go edit the existing patches to fix this,
> 
> OOPS!  I just saw your -stable commit.
> 
> Slight misunderstanding, Greg...
> 
> Out of those six patches that I sent to you, only "cx24123: fix PLL
> divisor setup" is a DVB patch... The remaining 5 patches are V4L patches.
> 
> Sorry for the confusion.

Ok, can you check this latest change to make sure I got it right this
time?  And the .17 patches were all DVB: right?

thanks,

greg k-h
