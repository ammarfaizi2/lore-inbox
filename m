Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285122AbRLQM4K>; Mon, 17 Dec 2001 07:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285125AbRLQM4A>; Mon, 17 Dec 2001 07:56:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18707 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285122AbRLQMzw>; Mon, 17 Dec 2001 07:55:52 -0500
Date: Fri, 14 Dec 2001 12:50:18 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Eric S. Raymond" <esr@thyrsus.com>, jaharkes@cs.cmu.edu,
        Cameron Simpson <cs@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@caldera.de>,
        Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: Re: CML2 with python1
Message-ID: <20011214125017.A37@toy.ucw.cz>
In-Reply-To: <20011204120305.A16578@thyrsus.com> <E16BJcB-0002o7-00@the-village.bc.nu> <20011205125938.A21170@zapff.research.canon.com.au> <20011205032954.B4836@thyrsus.com> <20011205051734.A22345@cs.cmu.edu> <20011212021709.A8076@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011212021709.A8076@thyrsus.com>; from esr@thyrsus.com on Wed, Dec 12, 2001 at 02:17:09AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> > But it _is_ entirely practical to run CML2 with a bog-standard python
> > 1.5 interpreter. I just did a search/replace for the python2-ism's like
> > 
> >  <x> += <y>           =>  <x> = <x> + <y>, and
> >  <string>.<op>(<arg>) => string.<op>(<string>, <arg>)
> > 
> > Worked around some missing functionality in the older shlex and curses
> > modules and I can now use oldconfig, menuconfig, xconfig, and cmladvent
> > with CML2 and a python1 interpreter. It also still works fine with
> > python2 as well.
> > 
> > 	http://ravel.coda.cs.cmu.edu/cml2-1.9.4-python1.patch (36K)
> > 
> > 36K might sound like a lot, but given the fact that the CML python
> > sources totals about 280KB, it is a pretty small diff, and the whole
> > "but python2 isn't standard in distributions and the license is bad"
> > argument can be dropped and we can get on with life.
> 
> It's a good try.  But there are some important things missing from
> this patch -- notably the Textpad class, which is needed for doing
> popup queries correctly.  
...
> I personally added the ncurses/Textpad/ascii features to the Python
> libraries shipped in 2.0, and I did it for a reason -- to support what
> 
