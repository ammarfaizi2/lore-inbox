Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276402AbRI2BhG>; Fri, 28 Sep 2001 21:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276404AbRI2Bg5>; Fri, 28 Sep 2001 21:36:57 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:30730 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S276402AbRI2Bgo>; Fri, 28 Sep 2001 21:36:44 -0400
Message-ID: <3BB52510.7D41538A@osdlab.org>
Date: Fri, 28 Sep 2001 18:34:08 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.21.0109261635190.957-100000@freak.distro.conectiva> <Pine.LNX.4.33.0109270746150.1679-100000@localhost.localdomain> <20010928010819.A434@turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Sep 27, 2001  08:38 +0200, Ingo Molnar wrote:
> > the patch also includes Andrew Morton's suggestion to add the
> > HAVE_POLL_CONTROLLER define for easier network-driver integration. The
> > eepro100.c changes now use this define.
> >
> > the new utilities-tarball is at:
> >
> > http://redhat.com/~mingo/netconsole-patches/netconsole-client-20010927.tar.gz
> 
> A few minor changes to the code, after testing it a bit locally (note that I
> am using kernel patch C1):

[snip]

> Finally, a patch to netconsole-client.c which does a few things:
> - remove "offset" from output, it appears meaningless and screws formatting.
> - allow the client to receive messages from multiple servers, unless a
>   single server is specified.

> TODO: allow client/server to be specified by both hostname/IP
> TODO: allow different client/server port numbers?  Do we care?

Hi,

I hope to be able to use this, but...

I must admit that I'm confused by the terms server, client, and
target.

1.  This is what I first thought:

server = the logging machine, client = machine under test,
and that "target" = client?

2.  Then I was told this:
target == the machine to log to (== logging server)

so I thought that if the target is the server, then the client
must run on the machine under test.  But the client program
won't be started early enough during boot for that to help me.

3.  Then I was told this:
netconsole-client is the server
and
mingo should rename it ;-)

4.  And finally this:
netconsole-client == target
kernel == source


WHOA!  Stop the presses.  Can someone say this more clearly,
and I'd suggest not using 3 names when 2 will do (probably
get rid of "target" and use client/server, or use some
other terminology).

~Randy
