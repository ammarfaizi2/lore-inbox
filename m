Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbRGEIVg>; Thu, 5 Jul 2001 04:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264851AbRGEIVZ>; Thu, 5 Jul 2001 04:21:25 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:12306 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264864AbRGEIVN>; Thu, 5 Jul 2001 04:21:13 -0400
Message-ID: <3B442354.BCA61010@idb.hist.no>
Date: Thu, 05 Jul 2001 10:20:36 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
[...]
> We migth want to just make initrd a built-in thing in the kernel,
> something that you simply cannot avoid. A lot of these things (ie dhcp for
> NFS root etc) are right now done in kernel space, simply because we don't
> want to depend on initrd, and people want to use old loaders.
> 
> I don't like the current initrd very much myself, I have to admit. I'm not
> going to accept a "you have to have a ramdisk" approach - I think the
> ramdisks are really broken.
> 
> But I've seen a "populate ramfs from a tar-file built into 'bzImage'"
> patch somewhere, and that would be a whole lot more palatable to me.
> 
> If anybody were to send me a patch that just unconditionally does this, I
> would probably not be adverse to putting it into 2.5.x. We have all the
> infrastructure to make all this a lot cleaner than it used to be (ie the
> "pivot_root()" stuff etc means that we can _truly_ do things from user
> mode, with no magic kernel flags).
> 
I am fine with "You have to use initrd (or similiar) _if_ you want this
feature."
But please don't make initrd mandatory for those of us who don't
need ACPI, don't need dhcp before mounting disks and so on.

I hope the "fs-less" kernel image still will be possible for those
of us who have a simple setup.

Helge Hafting
