Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316606AbSEaS5i>; Fri, 31 May 2002 14:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316640AbSEaS5h>; Fri, 31 May 2002 14:57:37 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:38921 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316606AbSEaS5h>;
	Fri, 31 May 2002 14:57:37 -0400
Date: Fri, 31 May 2002 11:55:50 -0700
From: Greg KH <greg@kroah.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB host drivers test results (2.5.19) and problem.
Message-ID: <20020531185549.GF1886@kroah.com>
In-Reply-To: <20020531133429.GF8310@come.alcove-fr> <21481.1022856842@redhat.com> <20020531163914.GB1250@kroah.com> <20020531184442.GB10621@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 03 May 2002 16:41:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 08:44:42PM +0200, Stelian Pop wrote:
> On Fri, May 31, 2002 at 09:39:14AM -0700, Greg KH wrote:
> 
> > > >  1. Shouldn't the ehci/ohci drivers give some error on loading, since
> > > > I obviously don't have the hardware ? 
> > > 
> > > How do they know that? You could have it in your hand and be just about to
> > > insert it.
> > 
> > They should not load, like any other pci driver that should not load if
> > you don't have the hardware present for it.
> 
> What about the PCI hotplug case, as David suggested ?

When the pci hotplug core sees a new device it calls out to
/sbin/hotplug to load any available driver (if necessary).  So if you
later plug in the device, everything will work just fine.

Well, that's the way it's _supposed_ to work, but the pci core changes
in 2.5.19 seem to have broken this too :(

/me looks for Pat Mochel...

thanks,

greg k-h
