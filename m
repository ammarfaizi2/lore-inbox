Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271966AbRIEKKD>; Wed, 5 Sep 2001 06:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271994AbRIEKJo>; Wed, 5 Sep 2001 06:09:44 -0400
Received: from [209.10.41.242] ([209.10.41.242]:63650 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S271988AbRIEKJe>;
	Wed, 5 Sep 2001 06:09:34 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getpeereid() for Linux
In-Reply-To: <tgsne23sou.fsf@mercury.rus.uni-stuttgart.de.suse.lists.linux.kernel>
	<oupae0ax8vq.fsf@pigdrop.muc.suse.de>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 05 Sep 2001 12:05:50 +0200
In-Reply-To: <oupae0ax8vq.fsf@pigdrop.muc.suse.de> (Andi Kleen's message of "05 Sep 2001 11:52:09 +0200")
Message-ID: <tgu1yi2br5.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE> writes:
> 
> > Would anyone like to give me a helping hand in implementing the
> > getpeereid() syscall for Linux?  See the following page for the
> > documentation of the OpenBSD implementation:
> 
> It is implemented for unix sockets (see unix(7))

Hmm, it is not documented in my local copy (?).  getpeereid() is
different from the standard credential passing mechanism because it
does not require cooperation of the other end.

> For TCP it is rather useless because it would work only locally.

Obviously, we need it only locally. ;-) The interface is useful if you
are implementing poor man's VPN in user space.

> If you trust the localhost you're probably better off using the
> ident protocol for it.

This means running just another server, even with root privileges. :-(

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
