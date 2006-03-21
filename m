Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWCUXYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWCUXYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbWCUXYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:24:44 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:51423 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751099AbWCUXYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:24:43 -0500
Date: Wed, 22 Mar 2006 00:24:12 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>, Pavel Machek <pavel@ucw.cz>,
       Phillip Lougher <phillip@lougher.org.uk>,
       Al Viro <viro@ftp.linux.org.uk>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
Message-ID: <20060321232412.GA9044@wohnheim.fh-wedel.de>
References: <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060319163249.GA3856@ucw.cz> <4420236F.80608@lougher.demon.co.uk> <20060321161452.GG27946@ftp.linux.org.uk> <44204F25.4090403@lougher.org.uk> <20060321191144.GB3929@elf.ucw.cz> <44205C1A.4040408@lougher.demon.co.uk> <20060321212853.GV6199@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060321212853.GV6199@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 March 2006 14:28:53 -0700, Andreas Dilger wrote:
> On Mar 21, 2006  20:03 +0000, Phillip Lougher wrote:
> > I don't want the lack of a fixed endianness on disk to become a problem. 
> >   I personally don't think the use of, or lack of a fixed endianness to 
> > be that important, but I'd prefer not to change the current situation 
> > and adopt a fixed format.  I use big endian systems almost exclusively, 
> > and I don't like the way fixed formats always tend to be little-endian.
> 
> If you want to squeak every last ounce of performance out of the filesystem,
> just have it declare two filesystem types - one for the little-endian, and
> one for the bit endian.  Generate one of them via "sed" from the other, to
> rename the functions, exports, etc, so they don't conflict.  Then, depending
> on the superblock magic it will mount the right filesystem, depending on
> endianness.  Since they are separate filesystems, normally only one module
> or the other need to be loaded at a time, and there is no runtime overhead.

That would be an interesting idea for quite another purpose:
measurement.

So far, there has been a lack of numbers in this thread.  Al mentioned
that conditional branches can be more expensive and I usually trust
his words, but actual cold hard numbers would help more.

> 	"unlisted-recipients: no To-header on input <;, Jeff Garzik" <jeff@garzik.org>,

I fixed this up.  No idea what garbled the header.

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra
