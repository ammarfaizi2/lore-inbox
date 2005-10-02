Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVJBSq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVJBSq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 14:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVJBSq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 14:46:29 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:32114 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751140AbVJBSq2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 14:46:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dfMyRBsj9q/KQmFOmjY5gGJezEhpNo3vAW2r47OzUMYbdGU1WLYwgV88XfS+cmS8CPOjTXx+kcQm9MSYu0LQKzFdQpL0y1B3aAHIPEIFsPHdJJb4r4xj0VgHWBW5Dn/MXP63v2aK2AjaZQn/DQZMHeerSxIEVwn151DamweZiA8=
Message-ID: <35fb2e590510021146m43badbe4xb6f8e3f63d6328ea@mail.gmail.com>
Date: Sun, 2 Oct 2005 19:46:25 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: lokum spand <lokumsspand@hotmail.com>
Subject: Re: A possible idea for Linux: Save running programs to disk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/05, lokum spand <lokumsspand@hotmail.com> wrote:

> I allow myself to suggest the following, although not sure if I post in
> the right group:

I've looked at similar, would have been my PhD area of interest.

> Suppose Linux could save the total state of a program to disk, for
> instance, imagine a program like mozilla with many open windows. I give
> it a SIGNAL-SAVETODISK and the process memory image is dropped to a
> file. I can then turn off the computer and later continue using the
> program where I left it, by loading it back into memory.

My interest is in having journalled processes at the system call level
so you can do full forward error recovery and resume on another node.
But in this day and age of webby stuff it's often not necessary for
the enterprise and a lot of hassle for everyone else (especially
preserving and handling network state). In any case, at OLS, I asked
the Xen folks about this and was told some people are apparently
looking into somehow "transactionalising" Xen so you'll be able to
checkpoint as you go and handle failover.

> Would that be possible? At least a program can be given a ctrl-z and is
> swapped out if physical memory is needed. This is somewhat similar (?)
> Would that need kernel parameters to be included in the process image
> file? What about X-windows resources? Is this simply to easy to exploit
> by having altered process images loaded back into the memory? ('virus')

I think that for very specific applications it would be possible,
others would make it much harder and necessary to have userland
support (even if not in the application itself). It's something I'd
recommend as a research topic due to it's open ended nature but I'm
not so sure we'll see this in Linux any time soon :-)

Jon.
