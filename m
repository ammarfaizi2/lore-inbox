Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbTBFXj2>; Thu, 6 Feb 2003 18:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbTBFXj2>; Thu, 6 Feb 2003 18:39:28 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:50314 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267542AbTBFXj1>;
	Thu, 6 Feb 2003 18:39:27 -0500
Date: Thu, 6 Feb 2003 18:49:16 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: John Bradford <john@grabjohn.com>, perex@perex.cz,
       linux-kernel@vger.kernel.org, greg@kroah.com, alan@lxorguk.ukuu.org.uk
Subject: Re: PnP model
Message-ID: <20030206184916.GC10021@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	John Bradford <john@grabjohn.com>, perex@perex.cz,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	alan@lxorguk.ukuu.org.uk
References: <F760B14C9561B941B89469F59BA3A84725A154@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A154@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 11:53:40AM -0800, Grover, Andrew wrote:
> > From: John Bradford [mailto:john@grabjohn.com] 
> > > I think the people who want to manually configure their device's
> > > resources need to step up and justify why this is really necessary.
> > 
> > Prototyping an embedded system, maybe, where you have devices in the
> > test box that won't be in the production machine.  You would want them
> > to use resources other than those that you want the hardware which
> > will be present to use.
>
> Ok fair enough. But I think the drivers should always think things are
> handled in a PnP manner, even if they really aren't. ;-) For example,
> between the stages where PnP enumerates the devices and the stage where
> drivers get device_add notifications as a result of that, we will be
> assigning the system resources to each device, but we could also
> implement a way at this stage for people to manually alter things. I
> think this is the right place to do this, as opposed to having all the
> drivers implement code to probe for themselves.
> 
> Thoughts?

I agree.  Actually the isapnp specifications (see Figure 2. Plug and Play ISA 
Configuration Flow for Plug and Play BIOS located in Plug and Play ISA
Specification Version 1.0a) recommend that the operating system configures
and activates all devices before drivers are loaded.  For the most part
linux plug and play follows this standard with the exception of manual
configuration support which is included in my latest patches.

Regards,
Adam
