Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136290AbREJM7n>; Thu, 10 May 2001 08:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136437AbREJM7f>; Thu, 10 May 2001 08:59:35 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47751 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136290AbREJM7V>;
	Thu, 10 May 2001 08:59:21 -0400
Date: Wed, 9 May 2001 23:09:36 -0700 (PDT)
From: <clameter@lameter.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB broken in 2.4.4? Serial Ricochet works, USB performance
 sucks.
In-Reply-To: <20010509203259.B4685@kroah.com>
Message-ID: <Pine.LNX.4.10.10105092307440.29655-100000@melchi.fuller.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2001, Greg KH wrote:
> Because currently the USB acm driver is not tuned for speed, reliability
> up to now has been more important :)

Allright then you should first check why the ACM driver is unable to
handle an MTU of 1500. I had to set it to 232 or 500 to make it work at
all. With an MTU of 1500 it does ICMP but not long tcp packets. There is
some issue with long packets that might exceed some buffer size(?).


