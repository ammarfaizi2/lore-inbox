Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbTDAQXL>; Tue, 1 Apr 2003 11:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbTDAQXJ>; Tue, 1 Apr 2003 11:23:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:48034 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262632AbTDAQVu>; Tue, 1 Apr 2003 11:21:50 -0500
Date: Tue, 1 Apr 2003 08:35:22 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, Joel Becker <Joel.Becker@oracle.com>,
       bert hubert <ahu@ds9a.nl>, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030401163522.GD1448@kroah.com>
References: <Pine.LNX.4.44.0303281031120.5042-100000@serv> <20030328180545.GG32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303281924530.5042-100000@serv> <20030331083157.GA29029@outpost.ds9a.nl> <Pine.LNX.4.44.0303311039190.5042-100000@serv> <20030331172403.GM32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303312215020.5042-100000@serv> <1049149133.1287.1.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0304010137250.5042-100000@serv> <1049208134.16073.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049208134.16073.11.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 03:42:14PM +0100, Alan Cox wrote:
> On Tue, 2003-04-01 at 00:42, Roman Zippel wrote:
> > Hi,
> > 
> > On 31 Mar 2003, Alan Cox wrote:
> > 
> > > > 2. What compromises can we make for 2.6?
> > > 
> > > Defaulting char devices to 256 minors and a lot of space so stuff doesnt
> > > break. Viro has done the block stuff and we have the scope to do sane
> > > stuff like /dev/disk/.. for all disks now.
> > 
> > What do you mean with "a lot of space so stuff doesnt break"?
> 
> We need to default to 12:20 for char but where the 20 is actually
> defaulting to 0000xx so we don't get extra minors for any device
> that hasnt been audited for it

I thought Andries's patch prevented the need for this, as it restricted
the number of minors assigned to a device unless they converted to the
new API.

thanks,

greg k-h
