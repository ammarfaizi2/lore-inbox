Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143474AbRAHNaW>; Mon, 8 Jan 2001 08:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143704AbRAHNaO>; Mon, 8 Jan 2001 08:30:14 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:64136 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S143474AbRAHNaD>; Mon, 8 Jan 2001 08:30:03 -0500
Date: Mon, 8 Jan 2001 15:29:04 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Shane Nay <shane@agendacomputing.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode
Message-ID: <20010108152904.K10035@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010108141702.I10035@nightmaster.csn.tu-chemnitz.de> <0101081213390Z.02165@www.easysolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <0101081213390Z.02165@www.easysolutions.net>; from shane@agendacomputing.com on Mon, Jan 08, 2001 at 12:13:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 12:13:39PM +0000, Shane Nay wrote:
> This may not initially seem like such a great thing..., but imagine a base 
> distro being distributed as a cramfs file.  Copy the thing over to your HD 
> and you're done, otherwise the distro packaging has to keep track of 
> permisions for each file, etc.

You can use (GNU-)tar for this. It even keeps track of other bits like
ext2fs attributes, AFAIK.

> On the other hand..., maybe I'm being "selfish", and this is the right way to 
> go. You never write to it, so why track the write bits?

Yes, I would consider this "selfish" ;-)

> (One answer is maybe later we can create a writable cramfs, but
> oh well)

This could then be solved with union mount and cramfs mount over
ramfs or any other writable Unix style fs.

Then we might need W bits, but currently they disturb things like
"test" and the perl equivalent, which is quite annoying and
complexifies code.  (Yes, I'm selfish too ;-))

See what Linus and Al think about this.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
