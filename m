Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbTDAPaF>; Tue, 1 Apr 2003 10:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbTDAPaF>; Tue, 1 Apr 2003 10:30:05 -0500
Received: from [81.2.110.254] ([81.2.110.254]:32495 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S262607AbTDAPaB>;
	Tue, 1 Apr 2003 10:30:01 -0500
Subject: Re: 64-bit kdev_t - just for playing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, bert hubert <ahu@ds9a.nl>,
       Greg KH <greg@kroah.com>, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
In-Reply-To: <Pine.LNX.4.44.0304010137250.5042-100000@serv>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl>
	 <Pine.LNX.4.44.0303272245490.5042-100000@serv>
	 <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.LNX.4.44.0303280008530.5042-100000@serv>
	 <20030327234820.GE1687@kroah.com>
	 <Pine.LNX.4.44.0303281031120.5042-100000@serv>
	 <20030328180545.GG32000@ca-server1.us.oracle.com>
	 <Pine.LNX.4.44.0303281924530.5042-100000@serv>
	 <20030331083157.GA29029@outpost.ds9a.nl>
	 <Pine.LNX.4.44.0303311039190.5042-100000@serv>
	 <20030331172403.GM32000@ca-server1.us.oracle.com>
	 <Pine.LNX.4.44.0303312215020.5042-100000@serv>
	 <1049149133.1287.1.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.LNX.4.44.0304010137250.5042-100000@serv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049208134.16073.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Apr 2003 15:42:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-01 at 00:42, Roman Zippel wrote:
> Hi,
> 
> On 31 Mar 2003, Alan Cox wrote:
> 
> > > 2. What compromises can we make for 2.6?
> > 
> > Defaulting char devices to 256 minors and a lot of space so stuff doesnt
> > break. Viro has done the block stuff and we have the scope to do sane
> > stuff like /dev/disk/.. for all disks now.
> 
> What do you mean with "a lot of space so stuff doesnt break"?

We need to default to 12:20 for char but where the 20 is actually
defaulting to 0000xx so we don't get extra minors for any device
that hasnt been audited for it


> > Glibc already has a bigger dev_t
> 
> and a broken mknod implementation...

Easy enough to deal with


