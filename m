Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262141AbSIZAzx>; Wed, 25 Sep 2002 20:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262142AbSIZAzx>; Wed, 25 Sep 2002 20:55:53 -0400
Received: from ns.suse.de ([213.95.15.193]:37900 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262141AbSIZAzw>;
	Wed, 25 Sep 2002 20:55:52 -0400
Date: Thu, 26 Sep 2002 03:01:05 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>, David Brownell <david-b@pacbell.net>,
       linux-kernel@vger.kernel.org, greg@kroah.com, mochel@osdl.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci and  usb
Message-ID: <20020926030105.A18617@wotan.suse.de>
References: <20020925212955.GA32487@kroah.com.suse.lists.linux.kernel> <3D9250CD.7090409@pacbell.net.suse.lists.linux.kernel> <p73k7l9si6p.fsf@oldwotan.suse.de> <20020925174612.A13467@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020925174612.A13467@one-eyed-alien.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 05:46:12PM -0700, Matthew Dharm wrote:
> On Thu, Sep 26, 2002 at 02:33:50AM +0200, Andi Kleen wrote:
> > David Brownell <david-b@pacbell.net> writes:
> > 
> > > > +	/* stuff we want to pass to /sbin/hotplug */
> > > > +	envp[i++] = scratch;
> > > > +	scratch += sprintf (scratch, "PCI_CLASS=%04X", pdev->class) + 1;
> > > > +
> > > > +	envp[i++] = scratch;
> > > > +	scratch += sprintf (scratch, "PCI_ID=%04X:%04X",
> > > > +			    pdev->vendor, pdev->device) + 1;
> > > 
> > > And so forth.  Use "snprintf" and prevent overrunning those buffers...
> > 
> > Hmm? An %04X format is perfectly bounded.
> 
> Technically, it isn't bounded.  The field will expand if the value exceeds
> 4 digits.  

It is bounded to 8 characters on linux systems (where int is always 32bit)

-Andi
