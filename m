Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136309AbREJNCp>; Thu, 10 May 2001 09:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136303AbREJM7j>; Thu, 10 May 2001 08:59:39 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47751 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136308AbREJM7X>;
	Thu, 10 May 2001 08:59:23 -0400
Date: Wed, 9 May 2001 23:25:26 -0700 (PDT)
From: <clameter@lameter.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB broken in 2.4.4? Serial Ricochet works, USB performance
 sucks.
In-Reply-To: <20010509222456.A4960@kroah.com>
Message-ID: <Pine.LNX.4.10.10105092324130.30061-100000@melchi.fuller.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2001, Greg KH wrote:

> On Wed, May 09, 2001 at 11:09:36PM -0700, clameter@lameter.com wrote:
> > 
> > Allright then you should first check why the ACM driver is unable to
> > handle an MTU of 1500. I had to set it to 232 or 500 to make it work at
> > all. With an MTU of 1500 it does ICMP but not long tcp packets. There is
> > some issue with long packets that might exceed some buffer size(?).
> 
> I don't see anything in the ACM driver that would cause a problem for
> large MTU settings.  It is probably a device limitation, not the driver.

The Richochet USB stuff uses generic serial I/O. No special driver. And it
works fine under Win/ME. Have you run a regular PPP connection over the
ACM driver with an MTU of 1500?


