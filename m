Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSGIMbK>; Tue, 9 Jul 2002 08:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSGIMbJ>; Tue, 9 Jul 2002 08:31:09 -0400
Received: from pD9E238F8.dip.t-dialin.net ([217.226.56.248]:47582 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314634AbSGIMbJ>; Tue, 9 Jul 2002 08:31:09 -0400
Date: Tue, 9 Jul 2002 06:33:47 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "David D. Hagood" <wowbagger@sktc.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Driverfs updates
In-Reply-To: <3D2AD518.6090706@sktc.net>
Message-ID: <Pine.LNX.4.44.0207090631110.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 9 Jul 2002, David D. Hagood wrote:
> Now, we have things like Firewire, USB, Bluetooth, PCMCIA, Hot-Plug PCI 
> and TCP/IP attached devices, all of which can come and go as they 
> please. Loadable modules made supporting such things easy - witness the 
> trouble WinNT had dealing with PCMCIA vs. Linux.
> 
> However, if you cannot unload modules, then the kernel grows without 
> bound - the mere fact that a Bluetooth camera came into range causes the 
> kernel to grow as the driver gets loaded. True, you could go in as root 
> and clean up, but it seems to me that requiring root to do that sort of 
> periodic maintainance prevents Linux from being able to be the Energizer 
> Bunny OS - "it keeps going and going...." without much diddling.

If you plug any hotplug devices, the kernel allocates some space for the 
control structures, and if you unplug it, structures get unallocated. No 
need to do it as a module. Kernel grows _and_ shrinks on runtime, even 
with CONFIG_MODULE=n.

> It seems to me the problem is in designing modules to unload, and saying 
> "Then don't unload them" is not even a band-aid - it is willful 
> ignorance. If there is a potential race condition unloading a module, 
> then the module is BROKEN.

Our discussion is not _whether_ to support module unloading, but how to 
support it sensibly on SMP systems.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

