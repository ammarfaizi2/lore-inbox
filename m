Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289106AbSAOEGM>; Mon, 14 Jan 2002 23:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289394AbSAOEFw>; Mon, 14 Jan 2002 23:05:52 -0500
Received: from waste.org ([209.173.204.2]:43175 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S289106AbSAOEFn>;
	Mon, 14 Jan 2002 23:05:43 -0500
Date: Mon, 14 Jan 2002 22:05:28 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Theodore Tso <tytso@mit.edu>, Juan Quintela <quintela@mandrakesoft.com>,
        Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
        <felix-dietlibc@fefe.de>, <andersen@codepoet.org>
Subject: Re: [RFC] klibc requirements, round 2
In-Reply-To: <20020114204830.E26688@lynx.adilger.int>
Message-ID: <Pine.LNX.4.44.0201142151410.12435-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Andreas Dilger wrote:

> > Interesting point. Modulo any existing LVM brokenness, we can do this with
> > a read-only snapshot and pivot_root afterwards. Alternately, a read-only
> > /bootsupport or something of the sort which contains *fsck. What we don't
> > want is initramfs to get big.
>
> Err, you think putting the necessary LVM tools in initramfs (vgscan,
> vgchange, lvcreate, liblvm) will be _smaller_ than e2fsck???

No, I forgot about that dependency entirely. Doh.

> Your "modulo" is also a very big one - I'd rather trust e2fsck than LVM
> in my boot environment any day.

Fair enough. The deeper point is that the purpose of initramfs is to move
stuff out of the kernel in to userland. Ergo, this all becomes a
non-kernel issue. We do not want to be in the business here of packaging
things into the ramfs archives, we rather want to give external tools and
distros all the info they need to make intelligent choices about how to
make the kernel bootable.

Let's just try to focus on what we're taking out of the kernel in this
process and not on all the nifty stuff that can now be added to the
initial boot process.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

