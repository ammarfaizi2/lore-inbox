Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285311AbRLFXpq>; Thu, 6 Dec 2001 18:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285312AbRLFXpl>; Thu, 6 Dec 2001 18:45:41 -0500
Received: from mail.gmx.de ([213.165.64.20]:59595 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285311AbRLFXp0>;
	Thu, 6 Dec 2001 18:45:26 -0500
Date: Fri, 7 Dec 2001 00:45:21 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Greg KH <greg@kroah.com>
Cc: jonathan@daria.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Q: device(file) permissions for USB
Message-Id: <20011207004521.19a131d4.rene.rebe@gmx.net>
In-Reply-To: <20011206152721.M2710@kroah.com>
In-Reply-To: <fa.ljcupnv.1ghotjk@ifi.uio.no>
	<664.3c0fd1b7.a66fa@trespassersw.daria.co.uk>
	<20011206223050.179cd30e.rene.rebe@gmx.net>
	<20011206152721.M2710@kroah.com>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 15:27:22 -0800
Greg KH <greg@kroah.com> wrote:

> On Thu, Dec 06, 2001 at 10:30:50PM +0100, Rene Rebe wrote:
> > 
> > This is what I do - but IT SUCKS!! Can't the USB stuff simply use devfs so
> > I can control the permissions of this USB nodes in a very nice / cleaner
> > way I do with all my other stuff??? (In contrast to use some find -name
> > | xargs chmod ... or simillar hacks ...)
> 
> How is using devfs (and devfsd) any different in "hack level" from using
> /sbin/hotplug?

Maybe nothing in Linux should be at an hack-level I we would like to
get more desktop users ;-) (NO I'm not such a dummie user!)

Devfsd:

REGISTER snd/* PERMISSIONS root.root 666
REGISTER sound/* PERMISSIONS root.root 666

For usbfs I have to do script-hacking in /sbin/hotplug (I do not know
how I did it since it is on my brothers box somewhere at the other
end of Germany ... - but is was some if [$1 = "usb"]; then; chmod
or maybe even some find /proc -name "xyz..." ...). Especially because
I only got one parameter ($1 == usb?) the rest was empty. So even
providing filesnames what got hot-plugged would be nice.

> usbdevfs does not require devfs, which enables the majority of Linux
> users to actually use it.

Wouldn't it be nicer to use devfs and add this procfs hack for the
"major dists"? - They could even mount devfs to /devfs and so use
all the old-way in /dev and only use devfs for the usb stuff.

I do not know why they adapt so slowly to such a cool technology
anyway ...

> thanks,
> 
> greg k-h

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
