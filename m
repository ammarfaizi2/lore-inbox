Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262114AbSIYV3G>; Wed, 25 Sep 2002 17:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbSIYV3F>; Wed, 25 Sep 2002 17:29:05 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:3593 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262114AbSIYV3E>;
	Wed, 25 Sep 2002 17:29:04 -0400
Date: Wed, 25 Sep 2002 14:33:03 -0700
From: Greg KH <greg@kroah.com>
To: Matt_Domsch@Dell.com
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: devicefs requests
Message-ID: <20020925213302.GB32487@kroah.com>
References: <20BF5713E14D5B48AA289F72BD372D68C1E8BD@AUSXMPC122.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68C1E8BD@AUSXMPC122.aus.amer.dell.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 02:28:57PM -0500, Matt_Domsch@Dell.com wrote:
> Pat,
> 
> 1)  As new drivers pick up the model, check that all xxx_bus_type objects
> get EXPORT_SYMBOLd and included in a include/xxxx header somewhere - My BIOS
> EDD code walks the list of bus types looking for attached devices to compare
> against (pci, ide, scsi, usb, ...).
> ide_bus_type is in include/linux/ide.h but isn't EXPORT_SYMBOL;
> usb_bus_type is in include/linux/usb.h but isn't EXPORT_SYMBOL;

But what do you do with the usb_bus_type?  Why would your code use
anything that is private to the driver core?

thanks,

greg k-h
