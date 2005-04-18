Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVDRHro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVDRHro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 03:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVDRHrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 03:47:43 -0400
Received: from smartmx-05.inode.at ([213.229.60.37]:23257 "EHLO
	smartmx-05.inode.at") by vger.kernel.org with ESMTP id S261873AbVDRHrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 03:47:40 -0400
Subject: Re: Booting from USB with initrd
From: Bernhard Schauer <linux-kernel-list@acousta.at>
To: gabriel <gabriel.j@telia.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <420333.1113682535160.JavaMail.root@pne-ps2-sn1>
References: <420333.1113682535160.JavaMail.root@pne-ps2-sn1>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 09:48:04 +0200
Message-Id: <1113810484.5418.36.camel@FC3-bernhard-1.acousta.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-16 at 22:15 +0200, gabriel wrote:
> Yeah.. but it shouldn't matter much since I've not been able to load the initrd 
> yet?
> 

I had just a look at all those things... It simply was a question coming
into my mind...

> My kernel never complains about root= bla it only says unable 
> to mount on root fs.
> I'm not sure what this tells us.

Unable to mount root is an error message telling us that /dev/ram0 could
not be mounted as root (root=)...

Try to remove the root=/dev/ram0 line from your kernel command line. IMO
you don't need it, cause the kernel mounts initrd as root in any case.

One other reason for that could be that syslinux does not find and load
the initrd into memory, so the kernel does boot without it.

> I hope so. I have it setup up like in the loop-aes readme. Is there something special 
> you have in mind?

Not in special. I searched some things like that with remote booting
linux and *lots* of questions/checks comes into my mind when reading
your lines.

> >Have you tried to boot kernel + initrd from your local linux
> >installation?

> No, I would if I knew how. Is there any howto for that?

Thats not that big issue. Do you have a linux installation with grub as
bootloader (If you only have KNOPPIX/KANOTIX it would be more
difficult)? 
If, copy your kernel & initrd to /boot and edit grubs config file -
normally somewhere within /boot. /etc/grub.conf should be a symlink.

If not copy kernel/initrd to some directory (root would be best) on a
known harddisk. Boot some live linux that uses grub as loader. Goto
grubs command line (edit the configuration to boot) and use your kernel
and initrd to boot (you need to know the number of the harddisk from
which you boot: hd(hdd nummer, part. nummer) ). See grubs documentation
for details.

Is there a message that initrd was loaded to mem (from syslinux)?

regards


PS: Your mail program does not fill in reference/in-reply-to header
fields... I would be very pleased if you could enable that feature (I'd
find your mails much easier ;-))

