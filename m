Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSJXVry>; Thu, 24 Oct 2002 17:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265690AbSJXVry>; Thu, 24 Oct 2002 17:47:54 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:57873 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265689AbSJXVrx>;
	Thu, 24 Oct 2002 17:47:53 -0400
Date: Thu, 24 Oct 2002 14:52:28 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] more pcibios_* removals for 2.5.44
Message-ID: <20021024215228.GL25159@kroah.com>
References: <20021022183152.GG6471@kroah.com> <20021024091037.A1346@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021024091037.A1346@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 09:10:37AM +0100, Russell King wrote:
> On Tue, Oct 22, 2002 at 11:31:52AM -0700, Greg KH wrote:
> > Attached is a patch for 2.5.44 that removes almost all of the remaining
> > usages of pcibios_read_config* and pcibios_write_config* calls.  It also
> > removes them from the pci.h, and drivers/pci/compat.c is gone.
> 
> You missed one in the pcmcia code.  I think this one will need a pseudo
> pci-device created just to use the new interface - the right pci device
> structure isn't anywhere in sight.
> 
> pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);

Oops, that was on my initial list, and didn't get copied into my email,
sorry about that.  Yes, that one will take a bit more work to clean up,
but isn't very difficult to do so.

thanks,

greg k-h
