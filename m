Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285323AbRLFX51>; Thu, 6 Dec 2001 18:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285325AbRLFX5R>; Thu, 6 Dec 2001 18:57:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:47592 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285322AbRLFX5M>;
	Thu, 6 Dec 2001 18:57:12 -0500
Date: Fri, 7 Dec 2001 00:57:07 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: greg@kroah.com, jonathan@daria.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Q: device(file) permissions for USB
Message-Id: <20011207005707.6a09706a.rene.rebe@gmx.net>
In-Reply-To: <Pine.GSO.4.21.0112061835010.29985-100000@binet.math.psu.edu>
In-Reply-To: <20011206152721.M2710@kroah.com>
	<Pine.GSO.4.21.0112061835010.29985-100000@binet.math.psu.edu>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 6 Dec 2001 18:37:44 -0500 (EST)
Alexander Viro <viro@math.psu.edu> wrote:

> On Thu, 6 Dec 2001, Greg KH wrote:
> 
> > On Thu, Dec 06, 2001 at 10:30:50PM +0100, Rene Rebe wrote:
> > > 
> > > This is what I do - but IT SUCKS!! Can't the USB stuff simply use devfs so
> > > I can control the permissions of this USB nodes in a very nice / cleaner
> > > way I do with all my other stuff??? (In contrast to use some find -name
> 
> Because anybody who uses devfs might as well make everything in /dev 666
> and do the same with /etc/shadow while we are at it?

Huh?? Not I!

LOOKUP loop/* MODLOAD

LOOKUP input/js* MODLOAD

LOOKUP ppp MODLOAD

LOOKUP usb/lp0 MODLOAD
REGISTER scsi/* PERMISSIONS root.daemon 660

The last is needed for CD buring - and this is a workstation anyway.

rene@jackson:/etc > l /etc/shadow
-rw-r-----   1 root     shadow        258 Nov 11 23:02 /etc/shadow

I really like devfs (most) for the sane names, and all the other features
found in Richards texts.

Where is THE problem with permissions??

Especially for the permissions point usbfs is bad. Because you never know
what device belongs to what. For examples replug a device or take the Canon
IXUS, wich switch off every 30 seconds without data-transfer. Each time you
get a new criptic usbfs file you have to chmod 666 it blindly ... ???

Btw. Linux might be more insecure due to the many bugs I had to stumble over
in the last month ... (-> so I decided to donate some time reporting each
bug I find [and for my newest RAID one I take a look myself ...])

> > > | xargs chmod ... or simillar hacks ...)
> > 
> > How is using devfs (and devfsd) any different in "hack level" from using
> > /sbin/hotplug?
> > 
> > usbdevfs does not require devfs, which enables the majority of Linux
> > users to actually use it.
> 
> s/majority of/& sane/

Writing bash scripts is easier than adding two lines to devfsd.conf?? Btw.
sane users do not use such a mahor/messy distro ...

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
