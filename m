Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262933AbTCYRAC>; Tue, 25 Mar 2003 12:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262970AbTCYRAC>; Tue, 25 Mar 2003 12:00:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2578 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262933AbTCYRAB>;
	Tue, 25 Mar 2003 12:00:01 -0500
Date: Tue, 25 Mar 2003 09:10:32 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i2c-via686a driver
Message-ID: <20030325171032.GB15823@kroah.com>
References: <3E7E0B37.5060505@portrix.net> <20030323202743.A11150@infradead.org> <200303232136.10089.dominik@kubla.de> <20030323204810.A11421@infradead.org> <3E7E2963.4070302@portrix.net> <20030325035451.GG11874@kroah.com> <3E801D8B.2040107@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E801D8B.2040107@portrix.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 10:12:43AM +0100, Jan Dittmer wrote:
> Greg KH wrote:
> >On Sun, Mar 23, 2003 at 10:38:43PM +0100, Jan Dittmer wrote:
> >
> >>Anyway, here is a corrected version.
> >
> >
> >Oops, one other thing.  The pci_device_id structure should be
> >initialized by using the .field = method, not the way the driver is
> >currently.
> >
> >Oh, and one patch that adds the Kconfig, Makefile, and driver to the
> >tree would be great.
> >
> I included that one with the first mail, but here it is again together 
> with the hopefully correctly fixed driver.

Yes, but you didn't include it all in one patch.  It's tough to apply a
.c file with 'patch' :)

Also, you need to set up the adapter.dev.parent pointer before calling
i2c_add_adapter().

Can you make that one change, and send a single patch?

thanks,

greg k-h
