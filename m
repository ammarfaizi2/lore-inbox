Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272076AbRIEKsF>; Wed, 5 Sep 2001 06:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272088AbRIEKrz>; Wed, 5 Sep 2001 06:47:55 -0400
Received: from ns.suse.de ([213.95.15.193]:41226 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272076AbRIEKrs>;
	Wed, 5 Sep 2001 06:47:48 -0400
Date: Wed, 5 Sep 2001 12:48:07 +0200
From: Andi Kleen <ak@suse.de>
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: getpeereid() for Linux
Message-ID: <20010905124807.A17035@gruyere.muc.suse.de>
In-Reply-To: <tgsne23sou.fsf@mercury.rus.uni-stuttgart.de.suse.lists.linux.kernel> <oupae0ax8vq.fsf@pigdrop.muc.suse.de> <tgu1yi2br5.fsf@mercury.rus.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <tgu1yi2br5.fsf@mercury.rus.uni-stuttgart.de>; from Florian.Weimer@RUS.Uni-Stuttgart.DE on Wed, Sep 05, 2001 at 12:05:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2001 at 12:05:50PM +0200, Florian Weimer wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE> writes:
> > 
> > > Would anyone like to give me a helping hand in implementing the
> > > getpeereid() syscall for Linux?  See the following page for the
> > > documentation of the OpenBSD implementation:
> > 
> > It is implemented for unix sockets (see unix(7))
> 
> Hmm, it is not documented in my local copy (?).  getpeereid() is
> different from the standard credential passing mechanism because it
> does not require cooperation of the other end.

SO_PEERCRED doesn't need any cooperation from the other end (at least 
not for SOCK_STREAM) 

> > For TCP it is rather useless because it would work only locally.
> 
> Obviously, we need it only locally. ;-) The interface is useful if you
> are implementing poor man's VPN in user space.

There is netfilter owner match, but it is a bad hack.

I think you're better off with identd. 

> 
> > If you trust the localhost you're probably better off using the
> > ident protocol for it.
> 
> This means running just another server, even with root privileges. :-(

identd doesn't need root.

-Andi
