Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289291AbSAOB1f>; Mon, 14 Jan 2002 20:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289348AbSAOB10>; Mon, 14 Jan 2002 20:27:26 -0500
Received: from waste.org ([209.173.204.2]:37535 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S289344AbSAOB1N>;
	Mon, 14 Jan 2002 20:27:13 -0500
Date: Mon, 14 Jan 2002 19:26:54 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Theodore Tso <tytso@mit.edu>, Juan Quintela <quintela@mandrakesoft.com>,
        Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
        <felix-dietlibc@fefe.de>, <andersen@codepoet.org>
Subject: Re: [RFC] klibc requirements, round 2
In-Reply-To: <20020114165849.B26688@lynx.adilger.int>
Message-ID: <Pine.LNX.4.44.0201141921580.2836-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Andreas Dilger wrote:

> Actually, the whole point of Juan's suggestion was that you _don't_ want
> to fsck a filesystem that is currently mounted.  There is always a
> potential problem that fsck will change the on-disk data of the filesystem
> in a way that is not coherent with what the kernel has in-memory, which
> should force a system reboot before continuing (which most initscripts
> don't do).  For ext2/ext3 this may be relatively safe (data/metadata don't
> move around much), but reiserfsck cannot (or will not) fsck a mounted
> filesystem at all.

Interesting point. Modulo any existing LVM brokenness, we can do this with
a read-only snapshot and pivot_root afterwards. Alternately, a read-only
/bootsupport or something of the sort which contains *fsck. What we don't
want is initramfs to get big.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

