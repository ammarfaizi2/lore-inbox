Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281480AbRK0QI7>; Tue, 27 Nov 2001 11:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281478AbRK0QIw>; Tue, 27 Nov 2001 11:08:52 -0500
Received: from AGrenoble-101-1-2-87.abo.wanadoo.fr ([193.253.227.87]:49281
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S281473AbRK0QIk> convert rfc822-to-8bit; Tue, 27 Nov 2001 11:08:40 -0500
Message-ID: <3C03BB6C.50701@wanadoo.fr>
Date: Tue, 27 Nov 2001 17:12:28 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: linuxlist@visto.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: mounting NTFS
In-Reply-To: <3BE042D00016CB26@iso1.vistocorporation.com> (added by	    administrator@vistocorporation.com)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rohit prasad wrote:

>  mount -t ntfs /dev/hda1 /mnt/msdos


seems fishy to mount an ntfs filesystem in
/mnt/msdos
:-)


> I get a message ntfs not supported, where as the manual on mount indicates that ntfs is supported / mountable.


NTFS needs to be supported by kernel to work.
do : "cat /proc/filesystems"
it should look like this, at least for the NTFS line :
~$ cat /proc/filesystems
nodev 
rootfs
nodev 
bdev
nodev 
proc
nodev 
sockfs
nodev 
tmpfs
nodev 
shm
nodev 
pipefs
nodev 
binfmt_misc
	ext2
	minix
	msdos
	vfat
	iso9660
nodev 
smbfs
	ntfs
nodev 
autofs
	reiserfs
nodev 
devpts
	xfs
nodev 
usbdevfs

If it doesn't, either you have to load the NTFS module :
"modprobe ntfs" should do the trick, or compile it directly
into your kernel, if you know how to do.

BTW write support for NTFS is dangerous, only works
(barely) for NT4 volumes, not W2K. You can read
from NTFS safely though.

Regards,

François Cami



