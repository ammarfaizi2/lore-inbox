Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVHRXQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVHRXQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 19:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVHRXQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 19:16:56 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3772 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932379AbVHRXQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 19:16:56 -0400
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
	(update)
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: e8607062@student.tuwien.ac.at, linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1124406811.20755.16.camel@localhost.localdomain>
References: <1124326652.8359.3.camel@w2>  <p7364u40zld.fsf@verdi.suse.de>
	 <1124381951.6251.14.camel@w2>  <1124389061.5973.33.camel@mindpipe>
	 <1124406811.20755.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 19:16:53 -0400
Message-Id: <1124407014.10991.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 00:13 +0100, Alan Cox wrote:
> On Iau, 2005-08-18 at 14:17 -0400, Lee Revell wrote:
> > Maybe the distros need to just increase the default FD limit to 1024.  I
> > hit this constantly with gtk-gnutella, if try to download a file that's
> > available on more than 1024 hosts it will open sockets until it hits
> > that limit then bomb out.
> 
> Sounds like a remarkably badly designed application. The author should
> perhaps look at the papers on tcp capture and efficiency unless they
> have a truely remarkably huge network pipe.
> 

OK say your DSL can dl at 350KB/sec.

A search for a 200MB file tells you it's available on 2000 hosts, all of
whom are on dialup.  You break it into 100 chunks and request a chunk
from what should be the fastest 100 hosts.  You wait a bit for the
speeds to stabilize and find you're only getting 150KB/sec aggregate, so
you reduce the size of the chunks and connect to 100 more hosts.  Repeat
until the pipe is full or you run out of FDs.

What's inefficient about this?  It's remarkably fast even for high
demand files and does not suck up all available upstream BW like
bittorrent and is leech-friendly ;-)

Lee

