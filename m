Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSIZA2f>; Wed, 25 Sep 2002 20:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261393AbSIZA2f>; Wed, 25 Sep 2002 20:28:35 -0400
Received: from ns.suse.de ([213.95.15.193]:29960 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261258AbSIZA2e>;
	Wed, 25 Sep 2002 20:28:34 -0400
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, mochel@osdl.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci and  usb
References: <20020925212955.GA32487@kroah.com.suse.lists.linux.kernel> <3D9250CD.7090409@pacbell.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Sep 2002 02:33:50 +0200
In-Reply-To: David Brownell's message of "26 Sep 2002 02:17:45 +0200"
Message-ID: <p73k7l9si6p.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell <david-b@pacbell.net> writes:

> > +	/* stuff we want to pass to /sbin/hotplug */
> > +	envp[i++] = scratch;
> > +	scratch += sprintf (scratch, "PCI_CLASS=%04X", pdev->class) + 1;
> > +
> > +	envp[i++] = scratch;
> > +	scratch += sprintf (scratch, "PCI_ID=%04X:%04X",
> > +			    pdev->vendor, pdev->device) + 1;
> 
> And so forth.  Use "snprintf" and prevent overrunning those buffers...

Hmm? An %04X format is perfectly bounded.

-Andi
