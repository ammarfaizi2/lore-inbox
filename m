Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312948AbSCZEiq>; Mon, 25 Mar 2002 23:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312949AbSCZEih>; Mon, 25 Mar 2002 23:38:37 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:49668
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312948AbSCZEi3>; Mon, 25 Mar 2002 23:38:29 -0500
Date: Mon, 25 Mar 2002 20:38:17 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Avi Schwartz <avi@CFFtechnologies.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 1G Microdrive problems
In-Reply-To: <1017115196.6309.62.camel@seahorse>
Message-ID: <Pine.LNX.4.10.10203252022310.2568-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Check to see of your drive has meta-data cache.
This is a solution to reduce power consumption in portable devices.
You may have problems with some inital data but some of the things which
these devices do is voodoo.

Also one set of images could be put to platter as memory and not disk.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On 25 Mar 2002, Avi Schwartz wrote:

> Hi,
> 
> I am looking for a pointer on where I can find help with a problem I am
> having with the IBM 1G Microdrive and Linux.  The problem I am having is
> not distribution specific.
> 
> The problem is that when I connect my digital camera (Olympus E-20) to
> my computer via USB (or the microdrive directly to my laptop via the
> PCMCIA adapter), trying to list the files on the disk displays a corrupt
> directory structure:
> 
> > ls /mnt/camera
> dcim
> 
> > ls /mnt/camera/dcim
> 100olymp
> 
> > ls -l /mnt/dcim/100olymp/
> dr-xr-xr-x    0 root     root        32768 Aug 10  1996 j4???h?".j?k
> -r-xr-xr-x    1 root     root     3547043402 Jun 20  2020 j{?e?8^?.c{?
> drwxr-xr-x  50768 root     root      3145728 Jan  1  2022 j?+?????.???
> drwxr-xr-x    0 root     root        32768 Dec 15  1911 kg?}?hv".???
> drwxr-xr-x    0 root     root        32768 Jan 14  1987 lt??????.???
> -r-xr-xr-x    1 root     root     290476329 Jan  4  1918 o?a?=??e.?8?
> -rwxr-xr-x    1 root     root      3650885 Dec 21 09:14 pc210028.jpg
> -rwxr-xr-x    1 root     root      3513694 Dec 21 09:16 pc210029.jpg
> -rwxr-xr-x    1 root     root      3653888 Dec 21 09:17 pc210030.jpg
> -rwxr-xr-x    1 root     root      3850982 Dec 23 19:50 pc230031.jpg
> ...
> 
> I tried it with different units, all had the same problem.
> 
> I formatted it more then once to make sure that the directory
> stucture is not corrupt and even then it displayed what seems to be a
> broken directory structure (i.e. when empty).
> 
> One thing to note is that the disk is formatted as fat, i.e. it is not
> ext2/3. 
> 
> It is not machine specific since I tried it with my desktop (via USB) as
> well as my laptop (via PCMCIA adapter).
> 
> The laptop is IDE based.  The desktop is SCSI.
> 
> The 'other' OS has no problem with these drives.
> 
> $ uname -a (on laptop)
> Linux seahorse 2.4.18 #3 Wed Feb 27 19:09:37 CST 2002 i686 GenuineIntel
> 
> Desktop is running kernel 2.4.7-SMP on a dual processor Athlon machine.
> 
> I can only think it might be a problem with the fat driver, any idea
> what may be the problem?
> 
> Thanks,
> Avi
> 
> -- 
> Avi Schwartz
> avi@CFFtechnologies.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

