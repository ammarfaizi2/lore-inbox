Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268802AbUIHE0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268802AbUIHE0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 00:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268805AbUIHE0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 00:26:16 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:42972 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268802AbUIHE0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 00:26:06 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: multi-domain PCI and sysfs
Date: Tue, 7 Sep 2004 21:25:41 -0700
User-Agent: KMail/1.7
Cc: jonsmirl@gmail.com, willy@debian.org, linux-kernel@vger.kernel.org
References: <9e4733910409041300139dabe0@mail.gmail.com> <200409072115.09856.jbarnes@engr.sgi.com> <20040907211637.20de06f4.davem@davemloft.net>
In-Reply-To: <20040907211637.20de06f4.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409072125.41153.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 7, 2004 9:16 pm, David S. Miller wrote:
> > A potentially cleaner option which Ben and I would prefer is to use
> > the vga device Jon is creating to do legacy I/O with explicit
> > read/write or ioctl calls.
>
> Definitely.  Note that xfree86 already has a signal handler for this
> stuff, ppc generates traps like sparc64 too.

Doing SIGBUS on ia64 was painful, due to the way the CPU chooses to not 
generate errors until bad data is actually consumed, but that's the approach 
we're taking at the moment.  I'd rather have the ioctls though, so I'm glad 
you're up for it.  My hope is that we can have a unified Linux device access 
method in X and get rid of all (or at least most) of the ppc/sparc/ia64/etc. 
specific hacks in the tree...

Jesse
