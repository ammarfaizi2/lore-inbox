Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161395AbWJKVb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161395AbWJKVb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422633AbWJKVbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:31:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:26835 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161383AbWJKVaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:30:04 -0400
Date: Wed, 11 Oct 2006 14:29:59 -0700
From: Greg KH <gregkh@suse.de>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: [patch 06/67] Video: cx24123: fix PLL divisor setup
Message-ID: <20061011212959.GA18006@suse.de>
References: <20061011204756.642936754@quad.kroah.org> <20061011210353.GG16627@kroah.com> <452D5EF7.80303@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452D5EF7.80303@linuxtv.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 05:15:35PM -0400, Michael Krufky wrote:
> Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> > 
> > ------------------
> > From: Yeasah Pell <yeasah@schwide.net>
> > 
> > The cx24109 datasheet says: "NOTE: if A=0, then N=N+1"
> > 
> > The current code is the result of a misinterpretation of the datasheet to
> > mean exactly the opposite of the requirement -- The actual value of N is 1
> > greater than the value written when A is 0, so 1 needs to be *subtracted*
> > from it to compensate.
> > 
> > Signed-off-by: Yeasah Pell <yeasah@schwide.net>
> > Signed-off-by: Steven Toth <stoth@hauppauge.com>
> > Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Greg,
> 
> When you apply this patch to your 2.6.18.y tree (and also to your
> 2.6.17.y tree) , can you please preceed the patch title with 'DVB'
> instead of 'VIDEO' ?
> 
> I'll be sure to specify the subsystem, instead of only the driver name
> in future patches.

Yes, it's better for you to specifiy it, instead of having me guess at
what it should be classified as :)

I'll try to go edit the existing patches to fix this,

thanks,

greg k-h
