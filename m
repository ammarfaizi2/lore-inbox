Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293747AbSCFS2N>; Wed, 6 Mar 2002 13:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293750AbSCFS2C>; Wed, 6 Mar 2002 13:28:02 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:44302 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293747AbSCFS1s>;
	Wed, 6 Mar 2002 13:27:48 -0500
Date: Wed, 6 Mar 2002 10:19:56 -0800
From: Greg KH <greg@kroah.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17,2.4.18 ide-scsi+usb-storage+devfs Oops
Message-ID: <20020306181956.GC16003@kroah.com>
In-Reply-To: <3C7EA7CB.C36D0211@sandino.net> <20020302075847.GE20536@kroah.com> <3C84294C.AE1E8CE9@sandino.net> <200203060528.g265Sh502430@vindaloo.ras.ucalgary.ca> <20020306053355.GA13072@kroah.com> <200203060545.g265jwL02756@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203060545.g265jwL02756@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 06 Feb 2002 16:11:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 10:45:58PM -0700, Richard Gooch wrote:
> Greg KH writes:
> > On Tue, Mar 05, 2002 at 10:28:43PM -0700, Richard Gooch wrote:
> > > 
> > > I suspect the USB-UHCI driver is doing a double-unregister on a devfs
> > > entry. Please set CONFIG_DEVFS_DEBUG=y, recompile and boot the new
> > > kernel. Send the new Oops (passed through ksymoops, of course).
> > 
> > None of the USB host controller drivers (like usb-uhci.c) call any
> > devfs functions.
> 
> Well, usb-uhci was in the call trace. Perhaps ksymoops was being given
> bogus input?

I agree, with symbols like:
	<[usb-uhci]__module_license+9099/fcd5>
it looks like this is the case.

thanks,

greg k-h
