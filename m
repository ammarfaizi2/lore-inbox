Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422711AbWCWW26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWCWW26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbWCWW26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:28:58 -0500
Received: from nproxy.gmail.com ([64.233.182.187]:61076 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422711AbWCWW25 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:28:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pr/EfrBkHIP9DFhkx3u6hY8ZqjVab3NjLPxLuNVD4YBoCXaHAMmEk1MKEZXboZZQgmG1RpSFdJ69Wddhl9XDzZ34JEqE1UYJcw5Cay65VtQ0RRXkUVohow7Czvm/VtTZ/Irf0nxPk44I9SkQnLL/q+ScCzk3bY88L7Ufm1Rx1bM=
Message-ID: <21d7e9970603231428t1172c5cdlaffe3603b920fc5a@mail.gmail.com>
Date: Fri, 24 Mar 2006 09:28:55 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [PATCH] [git tree] Intel i9xx support for intelfb
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <4422E171.1040909@worldonline.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>
	 <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
	 <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com>
	 <4422E171.1040909@worldonline.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/06, Sylvain Meyer <sylvain.meyer@worldonline.fr> wrote:
>         Sorry for my very long silence.
>
> For i2c support. I've done it to have a workable tv-out on my hardware.
> It was the main reason  why i ported the driver to kernels 2.6 as i use
> my computer as a set-top-box only connected to a tv. I've it on my own
> tree (very old).
> I can send you the code. I did it in a way not accepted by kernel
> reviewers as my tv driver (for chrontel ch7011 chipset) is all in kernel
> space. But it can be a base for a better scheme.

I actually have your code already, I picked it up on directfb-dev
quite a while back :-)

The i810 i2c code is nearly exactly the same as intelfb, they use the
same scheme, i9xx also support GMBUS, which means the chipset takes
over the bitbanging, you just give it a byte count and register... but
I'm not having the greatest luck reverse engineering it, hopefully
Intel will tell us how it might work at some point..

Im trying to figure out the architecture for moving a lot of stuff
into userspace, but keeping enough in kernel for people to do what
works now..

Dave.
