Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285881AbRLHJ6V>; Sat, 8 Dec 2001 04:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285887AbRLHJ6O>; Sat, 8 Dec 2001 04:58:14 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:55757 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S285881AbRLHJ5z>; Sat, 8 Dec 2001 04:57:55 -0500
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        "Roy S.C. Ho" <scho1208@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: question about kernel 2.4 ramdisk
In-Reply-To: <3C0D2843.5060708@antefacto.com>
	<E16BLxI-0003Ic-00@the-village.bc.nu>
	<snaqhzhj.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<m3wv02oz2w.fsf@linux.local> <20011206173755.D16513@zax>
Organisation: SAP LinuxLab
Message-ID: <m3snamhwle.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Date: 08 Dec 2001 10:53:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, 6 Dec 2001, David Gibson wrote:
> The options are different because the ramfs limits patch predates
> shmfs.

But tmpfs made it earlier into the kernel and if we want to merge the
ramfs patch we should unify the options.

>> Further thought: Wouldn't it be better to add a no_swap mount
>> option to shmem and try to merge the two? There is a lot of code
>> duplication between mm/shmem.c and fs/ramfs/inode.c.
> 
> Possibly.  In fact the patch to fs/ramfs/inode.c will be
> insufficient - the limits patch also requires a change to struct
> address_space_operations in fs.h, and also a change in mm/pagemap.c.
> shmfs applies the limits in a different way which doesn't need this, I
> haven't looked at it enough to see how it's done - by the time shmfs
> came around I'd moved on from the ramfs stuff.

I thought the patch in question does it without the removepage
operation.

> On the other hand one of the nice things about ramfs is it's
> simplicity and ramfs with limits is quite a bit less complex than
> shmfs. 

But the core of shmem is always compiled. And the rest is as simple as
ramfs...

Greetings
		Christoph


