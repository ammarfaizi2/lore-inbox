Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272675AbRHaMIO>; Fri, 31 Aug 2001 08:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272674AbRHaMIF>; Fri, 31 Aug 2001 08:08:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31617 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272672AbRHaMH5>; Fri, 31 Aug 2001 08:07:57 -0400
Date: Fri, 31 Aug 2001 08:08:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jim Roland <jroland@roland.net>
cc: Venkatesh Ramachandran <rvenky@cisco.com>, linux-users@cisco.com,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        brussels-linux@cisco.com, Mathangi Kuppusamy <mathangi@cisco.com>
Subject: Re: Linux Mounting problem
In-Reply-To: <3B8EAEC0.4090905@roland.net>
Message-ID: <Pine.LNX.3.95.1010831080054.26441A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Jim Roland wrote:

> He is getting these errors because his /etc/rc.d/rc.sysinit is shuttling 
> all output from the commands in the script to be written to /dev/null 
> and his FS is mounted as read-only.  It never gets mounted as read-write 
> because of fsck failing to approve the check with an OK status.  If 1-2 
> boots in rescue mode (or as "linux single") don't fix the errors, the 
> last step (e2fsck) should be run and should fix the error, unless there 
> is serious drive corruption.
> 
> Regards,
> Jim Roland, RHCE
> 
[SNIPPED...]

But you can write to a device that exists on a R/O disk! If the write
is not allowed, then the device-file has become corrupt and "seems to be"
a file, instead of a device..

Script started on Fri Aug 31 08:04:09 2001
# mount -o ro /dev/sdc1 /alt
# cd /alt
# ls
System.old  boot   dos	   exports  initrd  lost+found	proc  tmp  vmlinuz
alt	    cdrom  etc	   guru     laptop  mnt		root  usr  vmlinuz.old
bin	    dev    export  home     lib     opt		sbin  var
# >foo
bash: foo: Read-only file system
# cd dev
# >null
# ls -a >null
# file null
null: character special (1/3)
# pwd
/alt/dev
# cd ~
# umount /alt
# exit
exit
Script done on Fri Aug 31 08:05:25 2001

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


