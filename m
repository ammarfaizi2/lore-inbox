Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264952AbTF1AAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTF1AAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:00:51 -0400
Received: from snowman.net ([66.93.83.236]:41742 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id S264952AbTF1AAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:00:49 -0400
From: nick@snowman.net
Date: Fri, 27 Jun 2003 20:15:02 -0400 (EDT)
To: root@mauve.demon.co.uk
cc: "G. C." <gpc01532@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to Avoid GPL Issue
In-Reply-To: <200306280004.BAA23407@mauve.demon.co.uk>
Message-ID: <Pine.LNX.4.21.0306272013510.17138-100000@ns.snowman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you misunderstood the question.  He's not asking what he should
do, he's not asking what it would be nice for him to do.  He's asking what
the leagle minimum he can possibly do is.  He's not intrested in
"supporting linux" or anything like it, he meerly wants to be able to
stamp "Compatible with Linux $latest_redhat_release" on the front of the
box.
	Nick

On Sat, 28 Jun 2003 root@mauve.demon.co.uk wrote:

> > 
> > Dear Sir or Madam,
> > 
> > We are trying to port a third party hardware driver into Linux kernel and 
> > this third party vendor does not allow us to publish the source code. Is 
> > there any approach that we can avoid publicizing the third party code while 
> > porting to Linux? Do we need to write some shim layer code in Linux kernel 
> > to interface the third party code? How can we do that? Is there any document 
> > or samples?
> 
> The best way is to convince them to allow you to.
> Otherwise.
> 
> The right way is to write a spec for the hardware, based on the code.
> Now develop a GPL driver based on this spec.
> This is the best way to do it, and will result in a driver distributed with
> the kernel that can be maintained and used by anyone, likely on any 
> architecture that the thing can be plugged into, even if you don't decide
> to work on it any more, and the original vendor dies.
> 
> There are other ways.
> Probably the wrong way is to simply compile this module, and distribute
> the binary. 
> This will result in you needing to create at the very least dozens of binaries
> at each kernel upgrade, and your driver not working at all for many people
> that you haven't compiled for.
> 
> If you can't afford the time/cost to go the GPL route, probably the least 
> bad option is to move as much of the code as you can into a GPL'd interface
> module that talks to a small binary stub.
> Ideally the binary stub does not talk to the hardware, only to your 
> interface module. 
> This means that you need to compile only one stub per architecture, and
> even in the face of dramatic kernel changes, as the part that talks to the
> kernel (and hardware) is GPL, it can be fixed by anyone.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

