Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269206AbRGaGxI>; Tue, 31 Jul 2001 02:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269202AbRGaGw7>; Tue, 31 Jul 2001 02:52:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42813 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S269203AbRGaGwx>; Tue, 31 Jul 2001 02:52:53 -0400
To: Mike Touloumtzis <miket@bluemug.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch
In-Reply-To: <Pine.LNX.3.96.1010730153712.7347D-100000@mandrakesoft.mandrakesoft.com>
	<20010730140928.D20284@bluemug.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 31 Jul 2001 00:46:32 -0600
In-Reply-To: <20010730140928.D20284@bluemug.com>
Message-ID: <m1puahzjcn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Mike Touloumtzis <miket@bluemug.com> writes:

> On Mon, Jul 30, 2001 at 03:50:33PM -0500, Jeff Garzik wrote:
> > On Mon, 30 Jul 2001, Mike Touloumtzis wrote:
> > > 
> > > One thing that would make embedded systems developers very happy
> > > is the ability to map a romfs or cramfs filesystem directly from
> > > the kernel image, avoiding the extra copy necessitated by the cpio
> > > archive.  Are there problems with this approach?
> > 
> > Yes -- you need to at that point store initialized structures.  Store
> > the dcache in its unpacked state on the ROM image, etc.  That's the only
> > way to "map" a romfs directly.  Otherwise there is ALWAYS an unpacking
> > or translation step between filesystem image and in-memory image.
> > 
> > Mapping an in-memory image directly may seem like a good idea, but it is
> > really not.  ESPECIALLY for embedded folks.
> 
> I think you're misunderstanding what I propose.  I'm talking about
> having a device in /dev that would allow access to a filesystem
> image (cramfs or romfs) that would be embedded in the in-memory
> kernel image.

The current mtd drivers allow exactly this.  Having a filesystem on
your flash or rom device.  I don't think any filesystem that runs on
top of them currently supports XIP but the basic infrastructure is
there. 

Eric
