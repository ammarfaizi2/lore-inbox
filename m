Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbTDHUKl (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 16:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTDHUKl (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 16:10:41 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.27]:35446 "EHLO
	mwinf0404.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261760AbTDHUKj (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 16:10:39 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH] USB speedtouch: don't open a connection if no firmware
Date: Tue, 8 Apr 2003 22:22:10 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200304080926.43403.baldrick@wanadoo.fr> <20030408201239.GA5828@kroah.com>
In-Reply-To: <20030408201239.GA5828@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304082222.10919.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	udsl_fire_receivers (instance);
> >
> >  	dbg ("udsl_atm_open successful");
> >
> > +	MOD_INC_USE_COUNT;
> > +
> >  	return 0;
> >  }
>
> Any way you can convert this driver to not use MOD_INC_USE_COUNT, as
> it's racy and not really supported anymore?  But if you _really_ have to
> use it, you need to call it at the first possible chance to make any
> race window smaller.

Hi Greg, I'm waiting on the fixes to the ATM layer (coming soon to a kernel
near you).  As for the position of MOD_INC_USE_COUNT, did you ever hear
of anyone getting bitten by a race like this?  If it makes you feel better, I
will move it up, probably just before I take the semaphore (since that is the
first place we can sleep).  I will do it tomorrow, OK?

All the best,

Duncan.
