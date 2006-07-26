Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWGZHVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWGZHVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 03:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWGZHVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 03:21:11 -0400
Received: from ns1.suse.de ([195.135.220.2]:8335 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751603AbWGZHVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 03:21:10 -0400
Date: Wed, 26 Jul 2006 00:16:52 -0700
From: Greg KH <greg@kroah.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-stable <stable@kernel.org>
Subject: Re: [stable] Success: tty_io flush_to_ldisc() error message triggered
Message-ID: <20060726071652.GA6204@kroah.com>
References: <200607221209_MC3-1-C5CA-50EB@compuserve.com> <44C25548.5070307@microgate.com> <20060725184158.GH9021@kroah.com> <44C66D1C.7010903@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C66D1C.7010903@microgate.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 02:12:28PM -0500, Paul Fulghum wrote:
> Greg KH wrote:
> > On Sat, Jul 22, 2006 at 11:41:44AM -0500, Paul Fulghum wrote:
> > 
> >>Chuck Ebbert wrote:
> >>
> >>>The cleaner fix looks more intrusive, though.
> >>>
> >>>Is this simpler change (what I'm running but without the warning
> >>>messages) the preferred fix for -stable?
> >>
> >>It fixes the problem.
> > 
> > 
> > So do you feel this patch should be added to the -stable kernel tree?
> 
> No. Now that I think about it, adding that extra
> macro is just wrong even if temporary.
> 
> The real fix is equally simple, but in 2.6.18-rc
> it is intertwined with other more intrusive changes.
> 
> Let me make a new separate patch that does things
> the right way, which is simply removing the list
> head while processing the list so two instances
> to not trip over each other. I would have done so
> earlier, but I've been insanely busy with multiple
> work related deadlines (lame excuse I know).
> 
> I should post something tomorrow afternoon.

Ok, we can wait, I'd rather have the proper fix instead of the band-aid.

Just send it to stable@kernel.org when you have something that you feel
comfortable with.

thanks,

greg k-h
