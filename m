Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbTAIICp>; Thu, 9 Jan 2003 03:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbTAIICp>; Thu, 9 Jan 2003 03:02:45 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:1550 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262380AbTAIICo>;
	Thu, 9 Jan 2003 03:02:44 -0500
Date: Thu, 9 Jan 2003 00:10:58 -0800
From: Greg KH <greg@kroah.com>
To: Rus Foster <rghf@fsck.me.uk>
Cc: Dmitri <dmitri@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: Maybe OT: Unregistering a USB device
Message-ID: <20030109081057.GD8400@kroah.com>
References: <1041818057.5269.96.camel@usb.networkfab.com> <20030106072607.L27804-100000@freebsd.rf0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030106072607.L27804-100000@freebsd.rf0.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 07:27:12AM +0000, Rus Foster wrote:
> On 5 Jan 2003, Dmitri wrote:
> 
> > On Sun, 2003-01-05 at 15:09, Rus Foster wrote:
> >
> > Someone else asked this question earlier:
> >
> > http://marc.theaimsgroup.com/?l=linux-usb-users&m=104127472526623&w=2
> >
> > Dmitri
> 
> Ah right the problem is that
> a) I still want one of the usb-mass storage devices to still be accessible
> at the same time.
> b) My kernel is monolithic

You can use the USBDEVFS_DISCONNECT ioctl on the usb device node in
usbfs to disconnect the driver from the device.

Hope this helps,

greg k-h
