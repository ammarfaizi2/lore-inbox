Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289021AbSAZEyn>; Fri, 25 Jan 2002 23:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289022AbSAZEyd>; Fri, 25 Jan 2002 23:54:33 -0500
Received: from chmls06.mediaone.net ([24.147.1.144]:21738 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S289021AbSAZEyR>; Fri, 25 Jan 2002 23:54:17 -0500
Date: Fri, 25 Jan 2002 23:38:51 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, Dan Maas <dmaas@dcine.com>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Message-ID: <20020125233851.B10685@pimlott.ne.mediaone.net>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Dan Maas <dmaas@dcine.com>, Andreas Schwab <schwab@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020126034559.G5730@kushida.apsleyroad.org> <Pine.GSO.4.21.0201252327001.27397-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0201252327001.27397-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.23i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 11:33:44PM -0500, Alexander Viro wrote:
> 
> On Sat, 26 Jan 2002, Jamie Lokier wrote:
> 
> > I once wrote a Perl script that needed to know the current directory.
> > It did:
> > 
> >    use POSIX 'getcwd'
> >    getcwd(...)
> > 
> > After a few months, I was annoyed by the slowness of this script
> > (compared with other scripts) and decided to try speeding it up.  It
> > turns out that the above two lines took about 0.25 of a second, and that
> > was the dominant running time of the script.
> > 
> > I replaced getcwd() with `/bin/pwd`.  Lo!  It took about 0.0075 second.
> > 
> > Says very good things about Linux' fork, exec and mmap times, and about
> > Glibc's dynamic loading time, I think.
> 
> Most likely it says very bad things about getcwd() implementation in Perl
> compared to sys_getcwd() in the kernel.

No no no--it says very bad things about 'use POSIX', and in general
about overhead-creep in the perl library.

Andrew
