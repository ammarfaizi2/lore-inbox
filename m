Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbTIFQ3x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 12:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTIFQ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 12:29:53 -0400
Received: from web40405.mail.yahoo.com ([66.218.78.102]:56409 "HELO
	web40405.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262916AbTIFQ3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 12:29:51 -0400
Message-ID: <20030906162949.27200.qmail@web40405.mail.yahoo.com>
Date: Sat, 6 Sep 2003 09:29:49 -0700 (PDT)
From: Joshua Weage <weage98@yahoo.com>
Subject: Re: NFS client problems in 2.4.18 to 2.4.20
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <shshe3qnbtb.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have read through them and did some tuning a few months ago.  The
only thing that seems relevant to this problem is UDP buffer overflows,
but I'm using the 2.4.20 kernel.  I'm using 8192 byte read and write
sizes and have increased the number of nfsd's and socket buffer size on
the server.  Everything was working fine until about 4 weeks ago when
the mounts on the clients started locking up.  The server is dropping
packets at times, but increasing nfds only manages to load the disk
further - it doesn't seem to reduce timeouts.  However, I don't
understand why a mount on a single client will go AWOL - and never come
back - while all the others will continue to work properly.

Are there any commands that would allow me to figure out why the mount
has stopped working?  I've looked at nfsstat and the kernel seems to
have stopped sending any data to the server, or it may send one packet
every couple of seconds.  If I start up another shell and try to do an
ls on the problem filesystem, the command locks up and can't be
interrupted.  I think I've also mounted the same filesystem in another
location, on the same machine, and it works fine.

Josh

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >>>>> " " == Joshua Weage <weage98@yahoo.com> writes:
> 
>      > Any suggestions on what could be causing this?
> 
> Have you read through the sections pertaining to these problems in
> the
> NFS HOWTO and NFS FAQ? If not, see http://nfs.sourceforge.net
> 
> Cheers,
>   Trond


=====


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
