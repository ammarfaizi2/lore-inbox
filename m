Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267442AbTA3IYv>; Thu, 30 Jan 2003 03:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267443AbTA3IYv>; Thu, 30 Jan 2003 03:24:51 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:270 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267442AbTA3IYu>; Thu, 30 Jan 2003 03:24:50 -0500
Date: Thu, 30 Jan 2003 08:34:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Change sendfile header
Message-ID: <20030130083411.B22879@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1030129215509.7114C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1030129215509.7114C-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Wed, Jan 29, 2003 at 10:03:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 10:03:04PM -0500, Bill Davidsen wrote:
> I suggest that the header holding the prototype for sendfile should not be
> in unistd.h because:
> 
> 1 - sendfile is not in SuS, an is extremely non-standard
> 2 - there is a sendfile in BSD and it's totally different
> 3 - there is no man page for sendfile in Solaris, but there is a
>     definition in one of the libraries which is not Linux compatible
> 4 - just putting the "not portable" warning in the man page to counteract
>     the impression given by the <unistd.h> is not enough, programmers
>     usually only read the man page  to get the args right.
> 
> Since Linux sendfile is totally applicable only to Linux, it would seem
> that a better name for the header file, like linux/sendfile.h, would be
> better. This has the advantage of not breaking executables, and requiring
> use of a header file which makes it much harder to overlook the
> portability issue.

You're rant is totally inappropinquate because:

 1 - this is a glibc issue, applications should not include kernel
     headers
 2 - there is no sendfile declaration in glibc's <unistd.h>
 3 - there _is_ a <sys/sendfile.h> for sendfile(64) in glibc
 4 - solaris _does_ have a linux-compatible sendfile now

