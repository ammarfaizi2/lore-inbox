Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290448AbSBGQvG>; Thu, 7 Feb 2002 11:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290417AbSBGQuq>; Thu, 7 Feb 2002 11:50:46 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:36798 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S289685AbSBGQuf>; Thu, 7 Feb 2002 11:50:35 -0500
Date: Thu, 7 Feb 2002 11:50:35 -0500
To: linux-kernel@vger.kernel.org
Cc: lord@regexps.com
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020207165035.GA28384@ravel.coda.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org, lord@regexps.com
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org>
User-Agent: Mutt/1.3.27i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 11:33:34PM -0800, Jeramy B. Smith wrote:
> Firstly, IANAFSN (I am not a Free Software Nazi) but there is this
> new GPL decentralized version control program called arch that is small
> and fits in well with the Unix way of using other small utils.

Tom, I cc'd you on this,

Yes it's very interesting and has several good ideas behind it, but it's
not ready yet.

$ du /opt/arch-1.0pre3
12100   /opt/arch-1.0pre3/bin
788     /opt/arch-1.0pre3/include
2588    /opt/arch-1.0pre3/lib
1640    /opt/arch-1.0pre3/libexec
17120	/opt/arch-1.0pre3

Hmm, I wouldn't call over 17MB small. It also has several name conflicts
with existing binaries, amongst others /bin/arch and /bin/readlink. This
breaks a lot when arch's binary directory is not first in the PATH
environment variable.

Then it has these {arch} names all over the place, about as bad as CVS
and SCCS, but it breaks tab-completion with GNU bash/readline too,
wouldn't .arch (or .{arch}) be a less invasive naming scheme? It's
changesets are definitely not close to being 'patch' compatible.

> When you get weird Bk errors because Larry changes the Open Logging stuff
> for the umpteenth time which forces you to upgrade to keep using Bk,
> just remember we told you so.

Have you tried to work your way through the arch sources yet? Just
trying to figure out where 'sb' is compiled, what it does and where it
is used took me a very long time.

Most of arch's helper libraries/programs (hackerlab/xxx-utils) already
have in my opinion perfectly reasonable existing solutions, i.e. there
is something called the POSIX standard, ftp/http file access by using
wget/curl/ncftpget. And why it needs to have it's own ftp-server built
in (which is what it looks like), I have no clue about that one.

Jan

