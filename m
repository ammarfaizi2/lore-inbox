Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281015AbRKGVpo>; Wed, 7 Nov 2001 16:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280980AbRKGVp2>; Wed, 7 Nov 2001 16:45:28 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:46836
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281011AbRKGVpI>; Wed, 7 Nov 2001 16:45:08 -0500
Date: Wed, 7 Nov 2001 13:45:00 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Christian Borntr?ger <linux-kernel@borntraeger.net>
Cc: "Zvi Har'El" <rl@math.technion.ac.il>, linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107134500.E20245@mikef-linux.matchmail.com>
Mail-Followup-To: Christian Borntr?ger <linux-kernel@borntraeger.net>,
	Zvi Har'El <rl@math.technion.ac.il>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0111072302460.12525-100000@leeor.math.technion.ac.il> <E161aDV-0005fn-00@mrvdom01.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E161aDV-0005fn-00@mrvdom01.schlund.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 10:25:12PM +0100, Christian Borntr?ger wrote:
> > /dev/root / ext2 rw 0 0
> > /dev/hda6 /home ext3 rw 0 0
> >
> > However, tune2fs -l on both /dev/hda1 (the root filesystem) and /dev/hda6
> > gives Filesystem features:      has_journal sparse_super
> 
> You don use ext3.
> ext3 is backward compatible with ext2. So you can mount ext3 as ext2 
> completely ignoring the journal.
> 
> Look for a line in /etc/fstab
> /dev/root and change the file system to ext3.
> 

No.

This is chosen at boot time before /etc/fstab can be read...

check /proc/filesystems and make sure that ext3 is listed before ext2.

Also make sure that ext3 is compiled into the kernel.  You can use modules
if you want to mess with initrd, but I don't...

Mike
