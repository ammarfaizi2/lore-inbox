Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSIIRFv>; Mon, 9 Sep 2002 13:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSIIRFv>; Mon, 9 Sep 2002 13:05:51 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:36618 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317540AbSIIRFu>;
	Mon, 9 Sep 2002 13:05:50 -0400
Date: Mon, 9 Sep 2002 10:07:43 -0700
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Version 2 of the Linux IPMI driver
Message-ID: <20020909170743.GF5719@kroah.com>
References: <20020906201856.F26580@parcelfarce.linux.theplanet.co.uk> <3D790F2E.1050306@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D790F2E.1050306@acm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 03:25:18PM -0500, Corey Minyard wrote:
> You access a device as a filesystem?  That's bizarre.

Why?  There's lots of precedent for this model (usbfs, pcihpfs, etc.)

> It's a device, and they call them "devices" in the kernel for a
> reason.  Why would you want to do this?  Especially with devfs, the
> whole device numbering problem goes away.  You could easily make it a
> misc device.

devfs did not make the device numbering problem go away at all, you
still need to have a registered major/minor number with Lanana to use
devfs.  Yes, you can ask for a dynamic misc number, but that is very
difficult to support.

thanks,

greg k-h
