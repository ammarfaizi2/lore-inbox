Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289327AbSAPMB5>; Wed, 16 Jan 2002 07:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289349AbSAPMBs>; Wed, 16 Jan 2002 07:01:48 -0500
Received: from delrom.ro ([193.231.234.28]:26573 "EHLO delrom.ro")
	by vger.kernel.org with ESMTP id <S289327AbSAPMBc>;
	Wed, 16 Jan 2002 07:01:32 -0500
Date: Wed, 16 Jan 2002 14:02:08 +0200
From: Silviu Marin-Caea <silviu@delrom.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: Ramdisk doesn't work well in 2.4.17
Message-Id: <20020116140208.0636e00d.silviu@delrom.ro>
In-Reply-To: <20020115162647.35f57d4f.silviu@delrom.ro>
In-Reply-To: <20020115162647.35f57d4f.silviu@delrom.ro>
Organization: Delta Romania
X-Mailer: Sylpheed version 0.7.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__16_Jan_2002_14:02:08_+0200_085e2460"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__16_Jan_2002_14:02:08_+0200_085e2460
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jan 2002 16:26:47 +0200
Silviu Marin-Caea <silviu@delrom.ro> wrote:

Thanks to all who answered.

To Andrew Morton: unfortunately, the patch doesn't fix it for me.

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre2aa2/00_ramdisk-buffercache-2

This is what I do:

compile a kernel with the attached .config
Notes about configuration:
* Loopback device support
* Network block device support
* RAM disk support with a default size of 40960 (that's not an error)
disk size* Initial RAM disk initrd support

* No Kernel module loader

Tried kernel versions: 2.4.17, 2.4.18pre1 with the above patch,
2.4.18pre3 and pre4

Then:
rdev bzImage /dev/fd0 && rdev -r bzImage 49152 && rdev -R bzImage 0
dd if=bzImage of=/dev/fd0

Using this rootdisk:

http://prdownloads.sourceforge.net/partimage/partimage-0.6.1-i386-rootdisk-1.raw
I also tried with a modified version that uses a regular init, not
busybox.

This happens:

RAMDISK: Compressed image found at block 0
...
VFS: Mounted root (minix filesystem).
Freeing unused kernel memory: 204k freed
Kernel panic: no init found.  Try passing init= option to kernel.

> The root disk is good, because I have built a 2.4.9 in a similar
> fashion, and it works with it.  The problem is I need NTFS support,
> and that doesn't compile in 2.4.9.

-- 
Silviu Marin-Caea - Network & Systems Administrator - Delta Romania
Phone +4093-267961

--Multipart_Wed__16_Jan_2002_14:02:08_+0200_085e2460
Content-Type: application/x-gzip;
 name="kernelconfig.gz"
Content-Disposition: attachment;
 filename="kernelconfig.gz"
Content-Transfer-Encoding: base64

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
/464hWlPPgAA

--Multipart_Wed__16_Jan_2002_14:02:08_+0200_085e2460--

