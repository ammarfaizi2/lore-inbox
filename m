Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSI0GlY>; Fri, 27 Sep 2002 02:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbSI0GlY>; Fri, 27 Sep 2002 02:41:24 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:40972 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261322AbSI0GlX>;
	Fri, 27 Sep 2002 02:41:23 -0400
Date: Thu, 26 Sep 2002 23:45:06 -0700
From: Greg KH <greg@kroah.com>
To: jt@hpl.hp.com
Cc: Patrick Mochel <mochel@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Oops in device_shutdown()
Message-ID: <20020927064505.GA9118@kroah.com>
References: <20020927000115.GA19172@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927000115.GA19172@bougret.hpl.hp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 05:01:15PM -0700, Jean Tourrilhes wrote:
> 	o rmmod ohci-hcd usbcore

This step leaves usb bus nodes in driverfs.  I just noticed this today
when testing the hotplug patch I posted.  This is probably the cause of
your oops.  I'll work on finding and fixing this tomorrow.

Sorry about this.

greg k-h
