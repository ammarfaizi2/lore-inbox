Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317566AbSG2SMu>; Mon, 29 Jul 2002 14:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317567AbSG2SMu>; Mon, 29 Jul 2002 14:12:50 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:61202 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317566AbSG2SMs>;
	Mon, 29 Jul 2002 14:12:48 -0400
Date: Mon, 29 Jul 2002 11:15:01 -0700
From: Greg KH <greg@kroah.com>
To: martin@dalecki.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
Message-ID: <20020729181501.GD10153@kroah.com>
References: <1027553482.11881.5.camel@sonja.de.interearth.com> <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com> <20020727235726.GB26742@win.tue.nl> <20020728024739.GA28873@kroah.com> <3D4515E8.2010107@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4515E8.2010107@evision.ag>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 01 Jul 2002 16:28:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 12:16:08PM +0200, Marcin Dalecki wrote:
> Greg KH wrote:
> >On Sun, Jul 28, 2002 at 01:57:26AM +0200, Andries Brouwer wrote:
> >
> >>My third candidate is USB. Systems without USB are clearly more stable.
> >
> >
> >Hm, then that would imply that all of my systems are unstable :)
> >
> >Seriously, I don't know of any outstanding 2.5 USB issues that cause
> >oopses right now, or effect stability.  Any problems that people are
> >having, they sure are not telling me, or the other USB developers
> >about...
> >
> >thanks,
> 
> Please please learn how to use __FUNCTION__ properly. I see the same
> crap over and over again in security. OK?

{sigh}  This has _nothing_ to do with the stability of the code :)

I'd be glad to fix this, if someone sends me a patch.  I recently
accepted just such a patch for my 2.4 USB tree, as it is something that
eventually needs to get done.

And if you do send me such a patch, please test it out on older compiler
versions.  I just finally got the pci hotplug code fixed up after you
sent in a patch "fixing" this issue.

> Please tell me a way how to dual boot a system with the new host
> controller names between 2.4 and 2.5. Putting redundant alias lines in
> /etc/modules.conf didn't work.

Works for me :)

My modules.conf has the following two lines in it:
	alias usb-controller usb-uhci
	alias usb-controller uhci-hcd

Works just wonderfully for 2.2, 2.4, and 2.5.

thanks,

greg k-h
