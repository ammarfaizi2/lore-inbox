Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276220AbRI1SQH>; Fri, 28 Sep 2001 14:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276226AbRI1SPr>; Fri, 28 Sep 2001 14:15:47 -0400
Received: from www.diigroup.com ([208.132.17.2]:56068 "HELO
	aegis.indstorage.com") by vger.kernel.org with SMTP
	id <S276224AbRI1SPl>; Fri, 28 Sep 2001 14:15:41 -0400
From: n0ano@indstorage.com
Date: Fri, 28 Sep 2001 12:34:53 -0600
To: Eli Carter <eli.carter@inet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] core file naming option
Message-ID: <20010928123453.A892@tlaloc.indstorage.com>
In-Reply-To: <E15mHSd-0000mh-00@the-village.bc.nu> <3BB20F26.5575897B@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3BB20F26.5575897B@inet.com>; from eli.carter@inet.com on Wed, Sep 26, 2001 at 12:23:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli-

Having the 2.2.x series create `core.pid' is like a 2 line change
to `fs/binfmt_elf.c', just increase the size of the array that holds
the file name and `sprintf' the pid into it.  I've got a patch for
the 2.2.x series that dumps core for all threads and puts them in
`core.pid' files.

On Wed, Sep 26, 2001 at 12:23:50PM -0500, Eli Carter wrote:
> Alan Cox wrote:
> > 
> > > Other Unix' have used core.pid as the name. Wouldn't this be better?
> > > Especially when the process name is already stored in a core file
> > > (`file core` will give you this). Hmm I wonder could we use this
> > > core.pid format to dump the core for each thread (probably a bad idea).
> > 
> > The -ac tree and latest -linus can use core.pid for each thread already
> 
> Ah, I see: /proc/sys/kernel/core_uses_pid if I'm not mistaken.
> 
> However, my primary interest is with the 2.2.x series, and I don't see
> this in 2.2.19.
> Is this something that will be moving to 2.2.19?  Are there
> philisophical or technical reasons one way or the other?
> 
> Thank you for your time,
> 
> Eli
> --------------------.     Real Users find the one combination of bizarre
> Eli Carter           \ input values that shuts down the system for days.
> eli.carter(a)inet.com `-------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@indstorage.com
Ph: 303/652-0870x117
