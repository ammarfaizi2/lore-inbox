Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTKTXLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTKTXLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:11:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41919 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264060AbTKTXJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 18:09:09 -0500
Date: Thu, 20 Nov 2003 23:09:01 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hanna Linder <hannal@us.ibm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Martin Schlemmer <azarah@nosferatu.za.org>,
       Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: driver model for inputs
Message-ID: <20031120230901.GG24159@parcelfarce.linux.theplanet.co.uk>
References: <20031119213237.GA16828@fs.tum.de> <20031119221456.GB22090@kroah.com> <1069283566.5032.21.camel@nosferatu.lan> <20031119232651.GA22676@kroah.com> <20031120125228.GC432@openzaurus.ucw.cz> <20031120170303.GJ26720@kroah.com> <20031120222825.GE196@elf.ucw.cz> <55080000.1069368524@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55080000.1069368524@w-hlinder>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 02:48:44PM -0800, Hanna Linder wrote:
> --On Thursday, November 20, 2003 11:28:25 PM +0100 Pavel Machek <pavel@ucw.cz> wrote:
> 
> 
> >> tree.  Hanna Linder is working on the input sysfs patches, and has
> >> posted some work in the past.
> > 
> > I could only find 2.5.70 patches, and those did not seem "good enough"
> > to do power managment with them. Do you have some newer version?
> > 
> > [One of machines near me needs keyboard to be reinitialized after S3
> > sleep... And users are starting to hit that, too.]
> > 								Pavel
> 
> Hi Pavel,
> 
> I have test8 version of the patch which mostly works. The only problem now
> is a panic when I remove the mouse... The input layer is sorta hard to follow
> you know :) Im guessing it is a reference counting issue. Do you want what I
> have now or can I update it to test9 and see if taking a break from staring
> at it has helped?

Post it for review, please.  We are only now getting somewhat close to fixing
sysfs-related breakage in netdev and input layer is much more vile when it
comes to locking (and lack of it) and lifetime rules (ditto).
