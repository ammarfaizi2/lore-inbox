Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288209AbSAHSiz>; Tue, 8 Jan 2002 13:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288221AbSAHSiq>; Tue, 8 Jan 2002 13:38:46 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:52237 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288209AbSAHSin>;
	Tue, 8 Jan 2002 13:38:43 -0500
Date: Tue, 8 Jan 2002 10:36:35 -0800
From: Greg KH <greg@kroah.com>
To: Giacomo Catenazzi <cate@dplanet.ch>
Cc: esr@thyrsus.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
Message-ID: <20020108183635.GG14410@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0201070955480.867-100000@segfault.osdlab.org> <Pine.LNX.4.33.0201071908580.16327-100000@Appserv.suse.de> <20020107185001.GK7378@kroah.com> <20020107185813.GL7378@kroah.com> <3C3AA7FE.2060304@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3AA7FE.2060304@dplanet.ch>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 11 Dec 2001 16:19:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 09:04:14AM +0100, Giacomo Catenazzi wrote:
> modules.*map exist only on compiled kernel. And entry depends on
> architecture and on configuration.

I agree.  That's why something like what David has proposed would be
more helpful here.

> But don't worry. I use the kernel source to find the
> MODULES_DEVICE_TABLE (with a partially automated script) to build the
> new tables.

Do you check for devices that are now handled by different drivers?  For
example, the CDCEther and acm USB drivers have gone though a series of
different configuration changes, where one driver would claim devices
meant for the other.  It is hopefully all fixes up now, but might have
confused your scripts.

What about devices that are supported by more than one driver?  How do
you handle that?  (see the USB keyspan_pda and keyspan drivers for an
example.)

thanks,

greg k-h
