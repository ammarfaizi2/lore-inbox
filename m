Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281067AbRKDSAl>; Sun, 4 Nov 2001 13:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281064AbRKDSAW>; Sun, 4 Nov 2001 13:00:22 -0500
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:25613 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP
	id <S280970AbRKDSAF>; Sun, 4 Nov 2001 13:00:05 -0500
Date: Sun, 4 Nov 2001 17:59:45 +0000
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104175945.A91628@compsoc.man.ac.uk>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104163354.C14001@unthought.net> <160QM5-1HAz5sC@fmrl00.sul.t-online.com> <20011104172742Z16629-26013+37@humbolt.nl.linux.org> <20011104184159.E14001@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011104184159.E14001@unthought.net>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 06:41:59PM +0100, Jakob Østergaard wrote:

> The "fuzzy parsing" userland has to do today to get useful information
> out of many proc files today is not nice at all.  It eats CPU, it's 
> error-prone, and all in all it's just "wrong".

This is because the files are human-readable, nothing to do with binary vs. plain
text. proc should be made (entirely ?) of value-per-file trees, and a back-compat
compatprocfs union mounted for the files people and programs are expecting.

> However - having a human-readable /proc that you can use directly with
> cat, echo,  your scripts,  simple programs using read(), etc.   is absolutely
> a *very* cool feature that I don't want to let go.  It is just too damn
> practical.

I don't see that it's at all useful: it just makes life harder. You yourself
state above that read(2) parsing of human readable files is "not nice at all",
and now you're saying it is "just too damn practical".

Just drop the human-readable stuff from the new /proc, please.

In what way is parsing /proc/meminfo in a script more practical than 
cat /proc/meminfo/total ?

> > No, look, he's proposing to put the binary encoding in hidden .files.  The 
> > good old /proc files will continue to appear and operate as they do now.
> > 
>
> Exactly.

This just seems needless duplication, and fragile. Representing things as directory
hierarchies and single-value files in text seems to me to be much nicer, just as
convenient, and much nicer for fs/proc/ source...

IMHO
john

-- 
"All this just amounts to more grist for the mill of the ill."
	- Elizabeth Wurtzel
