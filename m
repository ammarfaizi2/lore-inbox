Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136303AbREJNCq>; Thu, 10 May 2001 09:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136066AbREJM7l>; Thu, 10 May 2001 08:59:41 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47751 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136317AbREJM7Y>;
	Thu, 10 May 2001 08:59:24 -0400
Date: Wed, 9 May 2001 22:38:13 -0700
From: Greg KH <greg@kroah.com>
To: clameter@lameter.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB broken in 2.4.4? Serial Ricochet works, USB performance sucks.
Message-ID: <20010509223813.B4980@kroah.com>
In-Reply-To: <20010509222456.A4960@kroah.com> <Pine.LNX.4.10.10105092324130.30061-100000@melchi.fuller.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10105092324130.30061-100000@melchi.fuller.edu>; from clameter@lameter.com on Wed, May 09, 2001 at 11:25:26PM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 11:25:26PM -0700, clameter@lameter.com wrote:
> 
> The Richochet USB stuff uses generic serial I/O. No special driver. And it
> works fine under Win/ME. Have you run a regular PPP connection over the
> ACM driver with an MTU of 1500?

The Linux USB ACM driver is the same "generic serial I/O" driver that
you speak of Win/ME having.  What is the MTU setting under Win/ME for
the device?

And no, I haven't run a PPP connection over a ACM device, as I do not
have an ACM device (otherwise I would have fixed the speed issues by now :)

But again, there are no packet size limitations in the driver, except as
such is specified by the specific device (endpoint size is determined by
the device, not the driver.)  So that would point to either a PPP
problem (maybe), or a device problem (probably, would have to have a
large buffer to handle a MTU of that size, and silicon isn't cheap for
tiny devices like modems.)

Hope this helps,

greg k-h
