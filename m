Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbQJ3X1N>; Mon, 30 Oct 2000 18:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129829AbQJ3X1D>; Mon, 30 Oct 2000 18:27:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5896 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129697AbQJ3X0t>; Mon, 30 Oct 2000 18:26:49 -0500
Message-ID: <39FE03B2.E3E12A23@transmeta.com>
Date: Mon, 30 Oct 2000 15:26:42 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: / on ramfs, possible?
In-Reply-To: <Pine.LNX.4.21.0010302323490.16101-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> On 29 Oct 2000, H. Peter Anvin wrote:
> 
> > > I want my / to be a ramfs filesystem. I intend to populate it from an
> > > initrd image, and then remount / as the ramfs filesystem. Is that at
> > > all possible? The way I see it the kernel requires / on a device
> > > (major,minor) or nfs.
> > >
> > > Am I out of luck using ramfs as /? If it's easy to fix, how do I fix it?
> > >
> >
> > Use pivot_root instead of the initrd stuff in /proc/sys.
> 
> Urgh. Then you're still using an initrd, and you still have to include all
> the crap necessary to support those horrid block-device thingies.
> 
> Why not just use a ramdisk?
> 

Pardon?!  This doesn't make any sense...

The question was: how do switch from the initrd to using the ramfs as /? 
Using pivot_root should do it (after the pivot, you can of course nuke
the initrd ramdisk.)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
