Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbTBQLka>; Mon, 17 Feb 2003 06:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTBQLka>; Mon, 17 Feb 2003 06:40:30 -0500
Received: from [213.86.99.237] ([213.86.99.237]:9967 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267023AbTBQLk3>; Mon, 17 Feb 2003 06:40:29 -0500
Subject: Re: ext3 clings to you like flypaper
From: David Woodhouse <dwmw2@infradead.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <78320000.1045465489@[10.10.2.4]>
References: <78320000.1045465489@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045482621.29000.40.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 17 Feb 2003 11:50:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-17 at 07:04, Martin J. Bligh wrote:
> Added a journal to my root disk.
> Mounted it ext3.
> Found it scaled like crap
> set my fstab back to ext2
> /dev/sda2       /               ext2    defaults,errors=remount-ro      0   1
> reboot.
> Disk says it's mounted ext2 ("mount\n")
> Still performs like crap.
> 
> Mmmmm ... it STILL mounts ext3.
> Allegedly this is a "feature".
> Can we please remove this stupidity?
> 
> If I say I want ext2, I want ext2 ....

Do you expect the kernel to read your /etc/fstab before mounting the
root file system, and then obey it?

Boot with 'rootfstype=ext2' and/or tune2fs -O ^has_journal /dev/sda2

-- 
dwmw2
