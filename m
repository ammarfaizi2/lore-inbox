Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbTI3MiL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbTI3MiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:38:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57833 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261419AbTI3MiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:38:06 -0400
Date: Tue, 30 Sep 2003 14:38:04 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930123804.GQ2908@suse.de>
References: <200309301157.h8UBvOcd004345@burner.fokus.fraunhofer.de> <20030930120629.GM2908@suse.de> <20030930052817.0d0272df.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930052817.0d0272df.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30 2003, David S. Miller wrote:
> On Tue, 30 Sep 2003 14:06:29 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > I asked you one simple question: when did the kernel/user interface
> > break, and how?
> 
> I'll answer for him, about 20 or 30 times during IPSEC development.

Sorry dave, that's a lame example. The fact that your (and who else did
ipsec) code/interface wasn't mature and thus changed interfaces in the
development series is perfectly acceptable in my book. But it sure as
hell must not happen between 2.4.20 and 2.4.21, for instance.

> It's still possible this could change even some more before 2.6.0
> final is released if a large enough bug in the IPSEC socket APIs are
> found in time.

As I wrote in the mail to Joerg, it should basically never happen unless
there's a damn good reason to. -testX series is still sort-of
development, so I'd accept such a change right now.

> But that's not the important issue, the important issue is that
> a huge number of kernel API interfaces have no equivalent in
> whatever you consider to be "user usable non-kernel headers".

And why is that?

> Find me the API defines for the IPSEC configuration socket interfaces
> in a header file that you think users should be allowed to include.

I wont go chasing your code, sorry. I'm sure you could come up with
that, if no usable interface exists how on earth are you expected to use
it from user space?

> You won't find it Jens, and that's why it drives me nuts when people
> spit out the "no kernel headers" mantra.  Often it simply must be
> done as a matter of practicality.

This discussion has spun off on a tangent. Joerg asked why that breakage
has not been fixed, I point out why that is so. I usually make sure that
whatever headers I mess with _do_ work from user space (cdrom.h is a
long nasty example), however it's never been guarenteed that this would
be the case for all kernel headers. Quite the opposite, in fact. And
back to my previous mail to you: if you do, be prepared to fix the
breakage yourself.

-- 
Jens Axboe

