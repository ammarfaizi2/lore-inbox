Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263849AbTDIX2s (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTDIX2r (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 19:28:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53196 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263849AbTDIX2q (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 19:28:46 -0400
Date: Wed, 9 Apr 2003 16:31:24 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] USB speedtouch: don't open a connection if no firmware
Message-ID: <20030409233124.GE3203@kroah.com>
References: <200304080926.43403.baldrick@wanadoo.fr> <200304082222.10919.baldrick@wanadoo.fr> <20030408214045.GA6376@kroah.com> <200304091028.25268.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304091028.25268.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 10:28:25AM +0200, Duncan Sands wrote:
> > > Hi Greg, I'm waiting on the fixes to the ATM layer (coming soon to a
> > > kernel near you).
> >
> > Ah, ok, that makes sense.
> >
> > > As for the position of MOD_INC_USE_COUNT, did you ever hear
> > > of anyone getting bitten by a race like this?  If it makes you feel
> > > better, I will move it up, probably just before I take the semaphore
> > > (since that is the first place we can sleep).  I will do it tomorrow, OK?
> >
> > Yes, it needs to be before any function that can sleep.  I'll hold off
> > applying this patch then.
> 
> How about this one instead.  MOD_INC_USE_COUNT is placed before I call
> any functions that can sleep.  Let's just hope that the call to me doesn't
> come after some sleeping in the higher layers...

Much better, thanks.  Applied.

greg k-h
