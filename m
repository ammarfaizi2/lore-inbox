Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264510AbRFJIjj>; Sun, 10 Jun 2001 04:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264509AbRFJIjU>; Sun, 10 Jun 2001 04:39:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45073 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264508AbRFJIjN>;
	Sun, 10 Jun 2001 04:39:13 -0400
Date: Sun, 10 Jun 2001 09:38:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, hofmang@ibm.net,
        linux-kernel@vger.kernel.org
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
Message-ID: <20010610093838.A13074@flint.arm.linux.org.uk>
In-Reply-To: <3B22CEF9.6DEB1A66@uow.edu.au> <Pine.LNX.4.33.0106100151090.9384-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106100151090.9384-100000@toomuch.toronto.redhat.com>; from bcrl@redhat.com on Sun, Jun 10, 2001 at 01:54:13AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2001 at 01:54:13AM -0400, Ben LaHaise wrote:
> I doubt it's related to pump: a few times I've seen the 3c59x driver drop
> the first few transmit packets.  Try loading the driver as a module and
> putting the whole modprobe ; ifconfig ; ping <somehost> set of commands
> into a script and watch what happens.  This goes for all ethernet driver
> writers.

Is this a change of requirements for ethernet drivers?  Many other drivers
do exactly the same (drop the first few packets while they're negotiating
with a hub), unless they're using 10base2, even back to the days of 2.0
kernels.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

