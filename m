Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135721AbRDSVgz>; Thu, 19 Apr 2001 17:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135722AbRDSVgq>; Thu, 19 Apr 2001 17:36:46 -0400
Received: from bing55.watson121.binghamton.edu ([128.226.121.55]:38157 "EHLO
	kybl") by vger.kernel.org with ESMTP id <S135721AbRDSVge>;
	Thu, 19 Apr 2001 17:36:34 -0400
Date: Thu, 19 Apr 2001 17:36:11 -0400
To: Giuliano Pochini <pochini@denise.shiny.it>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: I can eject a mounted CD
Message-ID: <20010419173611.A26995@kybl>
In-Reply-To: <3AD779CB.ED7C1656@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AD779CB.ED7C1656@denise.shiny.it>; from pochini@denise.shiny.it on Sat, Apr 14, 2001 at 12:12:28AM +0200
From: Tomas Jura <tjura@binghamton.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2001 at 12:12:28AM +0200, Giuliano Pochini wrote:
> 
> My fstab:
> 
> /dev/cdrom              /mnt/cdrom              iso9660 noauto,user,ro 0 0
> /dev/cdrom              /mnt/cdmac              hfs noauto,user,ro 0 0
> 
> I insert an apple cd (hfs) and mount /mnt/cdmac If I type eject /mnt/cdrom
> the cd momes out but df shows it's still mounted:
> 
> /dev/sr0                667978    667978         0 100% /mnt/cdmac
> 
> It's funny it don't let me eject cdmac
> 
> [Giu@Jay Giu]$ eject /mnt/cdmac/ umount: /dev/sr0 is not in the fstab (and
> you are not root) eject: unmount of `/dev/sr0' failed
> 

I have similar problem with my swim3 floppy drive. Digging deeply I found that
when I make do folowing steps then disk is lost and I have to reboot to get it
back:

floppy = open(/dev/fd0);
ioctl( floopy, FDGETDRVPRM, &fdp) /* some *invalid* ioctl */
exit

Device is lost for root too. It is impossible to make any operation on this
device anymore. And adding some debuging messages showed me that there is no
problem in swim3 device driver. Still digging...(but have no much time to do
this ;-( )

Hw&Sw: PowerPC G3 beige, kernel 2.4.3, devfs

Tomas

P.S. CC to me, I'm not in linux-kernel list. Only in linux-ppc


