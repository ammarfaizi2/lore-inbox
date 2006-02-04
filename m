Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWBDQ5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWBDQ5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 11:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWBDQ5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 11:57:24 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:27013 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932366AbWBDQ5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 11:57:24 -0500
Message-ID: <43E4DCBE.6080109@cfl.rr.com>
Date: Sat, 04 Feb 2006 11:56:30 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>, Phillip Susi <psusi@cfl.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <20060203180421. <20060204000205.GA4845@dspnet.fr.eu.org>
In-Reply-To: <20060204000205.GA4845@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2006 16:58:09.0473 (UTC) FILETIME=[2D1E9310:01C629AC]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14246.000
X-TM-AS-Result: No--6.350000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> The device node name?  From the rules in /etc/udev/rules.d/*.  Udev is
> the one which creates it in the first place, deriving it in a
> user-defined way from the sysfs information.  It does _not_ give back
> that information to the kernel.  Maybe it should.
>
>   
Ohh, I see what you are saying now.  Yes, it is up to udev to create the 
device nodes, and the kernel does not know or care about the nodes.  If 
an application wants to find existing nodes it can open it needs to 
query udev or hal.  If it wants to find out what devices the kernel 
exports, it can look in /sys and make its own devnode to access them. 

> The kernel does not provide a cd burning service, only a scsi packet
> transport service called SG_IO.
>
> The kernel *does* provide a device enumeration service, only it does
> it at this point through udev for reasons that are 50% technical and
>   
What part of the user/kernel separation don't you understand?  udev is 
user mode code which interfaces with the kernel via sysfs.  Other user 
mode code is free to do that as well, or just use udev.  Either way, the 
only kernel interface involved is sysfs.  The kernel does not know or 
care about udev or what it does,  only sysfs.  The kernel provides 
enumeration through sysfs, and that is all. 
> 50% political.  If you want to be able to use a 2.6 kernel with
> hotplug devices udev[1] is mandatory.  As such, from an engineering
> point of view, udev is part of the kernel even if it isn't in the
> source tarball on kernel.org.  And for now it is the lowest level
> interface to device enumeration.
>
>   

Your logic is flawed.  X + Y = Z does NOT mean that X ( linux ) and Y ( 
udev ) are one and the same even if Z ( a usable GNU/Linux system with 
hotplug support ) is desirable.  The kernel provides sysfs as it's 
interface, and udev and hal provide higher level interfaces.  In much 
the same way, the kernel frame buffer driver provides one interface, and 
Xorg provides higher level interface built on top of the kernel 
interface.  By no stretch of the imagination is Xorg the kernel 
interface to the video card, which is what you are arguing. 


