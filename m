Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132338AbRDMXQw>; Fri, 13 Apr 2001 19:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132385AbRDMXQm>; Fri, 13 Apr 2001 19:16:42 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:61970 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132338AbRDMXQY>;
	Fri, 13 Apr 2001 19:16:24 -0400
Date: Sat, 14 Apr 2001 01:16:02 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Friedrich Steven E CONT CNIN <friedrich_s@crane.navy.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: device driver questions
Message-ID: <20010414011602.E2290@pcep-jamie.cern.ch>
In-Reply-To: <AF6E1CA59D6AD1119C3A00A0C9893C9A04F57121@cninexchsrv01.crane.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <AF6E1CA59D6AD1119C3A00A0C9893C9A04F57121@cninexchsrv01.crane.navy.mil>; from friedrich_s@crane.navy.mil on Fri, Apr 13, 2001 at 03:10:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friedrich Steven E CONT CNIN wrote:
> 	If you want to mmap the device then you really want to put the
> device in its own 4K aligned 4K sized PCI window, otherwise adjacent
> devices will become accessible too and that might not be desirable.

If you can, reprogram the device's PCI configuration to have a 4k or
more sized window.  (You said you were willing to move functionality
into the hardware, so I assume you can do this).  That guarantees it
will be page aligned, and without other devices overlapping in
userspace.

-- Jamie
