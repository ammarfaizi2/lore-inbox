Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbSJNC4d>; Sun, 13 Oct 2002 22:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSJNC4d>; Sun, 13 Oct 2002 22:56:33 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:39940 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261837AbSJNC4c>;
	Sun, 13 Oct 2002 22:56:32 -0400
Date: Sun, 13 Oct 2002 20:02:47 -0700
From: Greg KH <greg@kroah.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 [0/4]
Message-ID: <20021014030247.GA1984@kroah.com>
References: <20021014022515.GB1768@kroah.com> <Pine.LNX.4.44.0210132145210.4554-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210132145210.4554-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 09:49:33PM -0500, Kai Germaschewski wrote:
> On Sun, 13 Oct 2002, Greg KH wrote:
> 
> > +ifeq ($(CONFIG_SUMMIT),y)
> > +MACHINE	= mach-summit
> >  endif
> >  
> > Can make handle reassigning a variable?
> 
> Sure.
> 
> You could even do
> 
> 	machine-y 			:= mach-generic
> 	machine-$(CONFIG_SUMMIT)	:= mach-summit
> 	...
> 	MACHINE				:= $(machine-y)

Oooh, nice.  You might want to go fix up arch/arm/Makefile, as that's
where I took my above example from :)

thanks,

greg k-h
