Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbSJCQgi>; Thu, 3 Oct 2002 12:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261704AbSJCQgi>; Thu, 3 Oct 2002 12:36:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56076 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261684AbSJCQgf>;
	Thu, 3 Oct 2002 12:36:35 -0400
Date: Thu, 3 Oct 2002 17:42:07 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Start of cleaning up socket ioctls
Message-ID: <20021003174207.I28586@parcelfarce.linux.theplanet.co.uk>
References: <20021003155241.G28586@parcelfarce.linux.theplanet.co.uk> <1033658599.28850.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033658599.28850.5.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 03, 2002 at 04:23:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 04:23:19PM +0100, Alan Cox wrote:
> Nice but one request - can you call the protocol handlers first and if
> they return -ENOTTY then call the default ones provided by the upper
> layer. That will let you remove even more common code to most versions,
> make it work like the serial and other layers do, and still let people
> override defaults

I'm trying to tread as lightly as possible at first.  I wasn't sure
how well this kind of cleanup would be received ;-)  The trouble with
doing what you've asked immediately is that not all ->ioctl methods
return -ENOTTY.  Some return -EINVAL, some return -EOPNOTSUPP and some
return -ENOPKG.  Yeah, this should probably get cleaned up, but baby
steps first.  I have no Grand Plan here, but I do want to make things
a little more understandable before I embark on anything bigger.

-- 
Revolutions do not require corporate support.
