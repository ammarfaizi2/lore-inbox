Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279987AbRKSQfM>; Mon, 19 Nov 2001 11:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279992AbRKSQfC>; Mon, 19 Nov 2001 11:35:02 -0500
Received: from web14804.mail.yahoo.com ([216.136.224.220]:58122 "HELO
	web14804.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S279987AbRKSQe5>; Mon, 19 Nov 2001 11:34:57 -0500
Message-ID: <20011119163455.11507.qmail@web14804.mail.yahoo.com>
Date: Mon, 19 Nov 2001 08:34:55 -0800 (PST)
From: Rock Gordon <rockgordon@yahoo.com>
Subject: Re: Executing binaries on new filesystem
To: Terje Eggestad <terje.eggestad@scali.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111181602220.1899-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All said and done, the file is with correct
permissions (for that matter any binary that I execute
on my filesystem has correct permissions). The only
thing strace tells me is "bad file format". The same
binary works perfectly elsewhere.

I don't think mmap is the problem; you don't need it
in order to run binaries ...

--- Terje Eggestad <terje.eggestad@scali.no> wrote:
> On Sat, 17 Nov 2001, Rock Gordon wrote:
> 
> > Hi,
> >
> > I've written a modest filesystem for fun, it works
> > pretty ok, but when I try to execute binaries from
> it,
> > bash says "cannot execute binary file" ... If I
> copy
> > the same binary elsewhere, it executes perfectly.
> >
> > Does anybody have any clue ?
> 
> Yes
> 
> keep in mind taht the kernel do demand paging of the
> text (code) in our
> executable, meaning that a page of code is not
> loaded into the procs
> memory spce (and thus phys mem) until the proc
> actually tries to exec the
> code page. This is one manifestation of the funny
> term "page fault"!
> 
> I do belive that the current kernel uses mmap to map
> in the exec file text
> segment. (Even if I can hear the ice cracking under
> my feet, never
> actually looked at the code handling execs) but if
> you strace anexec that
> uses shared libs you'll note that the sh.libs are
> mmaped into the process
> space. (also note the MMAP_EXEC flag in the mmap(2)
> man page).
> 
> 
> TJ
> 
> >
> > Regards,
> > Rock
> >
> > __________________________________________________
> > Do You Yahoo!?
> > Find the one for you at Yahoo! Personals
> > http://personals.yahoo.com
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> -- 
>
_________________________________________________________________________
> 
> Terje Eggestad                 
> terje.eggestad@scali.no
> Scali Scalable Linux Systems    http://www.scali.com
> 
> Olaf Helsets Vei 6              tel:    +47 22 62 89
> 61 (OFFICE)
> P.O.Box 70 Bogerud                      +47 975 31
> 574  (MOBILE)
> N-0621 Oslo                     fax:    +47 22 62 89
> 51
> NORWAY
>
_________________________________________________________________________
> 


__________________________________________________
Do You Yahoo!?
Find the one for you at Yahoo! Personals
http://personals.yahoo.com
