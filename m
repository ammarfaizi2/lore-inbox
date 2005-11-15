Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVKOIsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVKOIsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbVKOIsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:48:09 -0500
Received: from dave.ok.cz ([213.151.79.194]:30948 "EHLO awk.cz")
	by vger.kernel.org with ESMTP id S1751362AbVKOIsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:48:08 -0500
Date: Tue, 15 Nov 2005 09:48:01 +0100
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       gregkh@suse.de, torvalds@osdl.org, akpm@osdl.org
Subject: Re: USB patches for 2.6.15-rc1??
Message-ID: <20051115084801.GA13387@awk.cz>
References: <20051114200456.GA2319@kroah.com> <20051114200924.GA2531@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051114200924.GA2531@kroah.com>
User-Agent: Mutt/1.5.11
From: David Kubicek <dave@awk.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 12:09:24PM -0800, Greg Kroah-Hartman wrote:
> On Mon, Nov 14, 2005 at 12:04:56PM -0800, Greg Kroah-Hartman wrote:
> > Here are a few USB patches against your latest git tree, they have all
> > been in the past few -mm releases just fine.  They fix some build bugs,
> > add some new device ids, and add a new simple usb-serial driver.
> 
> Oh, forgot the combined diffstat of the whole series, sorry about that:
> 
>  Documentation/devices.txt            |   12 
>  Documentation/usb/bluetooth.txt      |   45 --
>  drivers/usb/core/devio.c             |    5 
>  drivers/usb/core/inode.c             |    8 
>  drivers/usb/core/message.c           |    4 
>  drivers/usb/gadget/dummy_hcd.c       |    5 
>  drivers/usb/input/hid-core.c         |   13 
>  drivers/usb/input/wacom.c            |  134 +++++-
>  drivers/usb/serial/ChangeLog.history |  730 ++++++++++++++++++++++++++++++++++
>  drivers/usb/serial/ChangeLog.old     |  731 -----------------------------------
>  drivers/usb/serial/Kconfig           |    9 
>  drivers/usb/serial/Makefile          |    1 
>  drivers/usb/serial/anydata.c         |  123 +++++
>  drivers/usb/serial/cp2101.c          |    2 
>  drivers/usb/serial/generic.c         |    2 
>  drivers/usb/storage/Kconfig          |    3 
>  drivers/usb/storage/unusual_devs.h   |    6 
>  17 files changed, 1000 insertions(+), 833 deletions(-)

Hi Greg,

may I ask you what about the "URB/buffer ring queue" patch I've
submitted months ago for CDC ACM modems and which you accepted into your
tree when Oliver sent it to you for merging like a week ago? We (tens of
thousands of users in Czech Rep.) are anxiously waiting for this patch
for almost three release cycles to be merged and still nothing
happens... I spent some time finding out the issue and fixing it for the
benefit of all broadband users in CR, who were quite happy that they
will be able to use their connection fully - most of them dual boots to
Windows if they want full speed!! (Horror!:)) The patch was extremely
tested, audited by two people, please - could you do it for us?

There is, maybe, possibly usable sped-up generic usb-serial version, but
I reckon that for CDC ACM modems should be used CDC ACM driver, when
available. And when it is available, it should also be usable as much as
possible - this includes transfer rates over 256kbits/s, which are quite
common (ten times that, actually!). Not to mention that you can't do
some important things with just the data-channel of the generic iface...

Thank you for your consideration,
David

-- 
David Kubíček
System Specialist

gedas ČR s.r.o.
Mladá Boleslav, Husova 217
Phone:  (420) 326 329 359
Mobile: (420) 724 073 280
Email:  dave@awk.cz
Web:    http://www.awk.cz
