Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135803AbRDTRpz>; Fri, 20 Apr 2001 13:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135822AbRDTRpt>; Fri, 20 Apr 2001 13:45:49 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:9965 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S135793AbRDTRpf>; Fri, 20 Apr 2001 13:45:35 -0400
Subject: Re: I can eject a mounted CD
From: Bastien Nocera <hadess@hadess.net>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Tomas Jura <tjura@binghamton.edu>, linuxppc-dev@lists.linuxppc.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.010420094955.pochini@shiny.it>
In-Reply-To: <XFMail.010420094955.pochini@shiny.it>
Content-Type: text/plain
X-Mailer: Evolution/0.10+cvs.2001.04.16.08.00 (Preview Release)
Date: 20 Apr 2001 18:41:15 +0100
Message-Id: <987788475.856.1.camel@kara>
Mime-Version: 1.0
Message-ID: <kara.2760-0.987788475@kara.hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Apr 2001 09:49:55 +0200, Giuliano Pochini wrote:
> 
> >> [Giu@Jay Giu]$ eject /mnt/cdmac/ umount: /dev/sr0 is not in the fstab (and
> >> you are not root) eject: unmount of `/dev/sr0' failed
> 
> Eject(1) is suid.

No, it's not on proper installations.
$  ls -l /usr/bin/eject 
 17k -rwxr-xr-x    1 root     root          16k Jan 29 01:14
/usr/bin/eject

You need to have write access to the device to eject it.
I guess you use something like /dev/cdrom as the device for the mount
point /mnt/cdmac, /dev/cdrom being a symlink to /dev/sr0.
Try 'eject /dev/cdrom' you'll probably have more luck.

<snip>

Cheers

-- 
/Bastien Nocera
http://hadess.net

