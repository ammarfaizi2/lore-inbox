Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130921AbRBCC2R>; Fri, 2 Feb 2001 21:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130939AbRBCC2H>; Fri, 2 Feb 2001 21:28:07 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:59829 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130938AbRBCC1w>; Fri, 2 Feb 2001 21:27:52 -0500
Date: Sat, 3 Feb 2001 02:27:37 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: David Lang <dlang@diginsite.com>
cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <Pine.LNX.4.31.0102021456000.1221-100000@dlang.diginsite.com>
Message-ID: <Pine.SOL.4.21.0102030225540.12570-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, David Lang wrote:

> Thanks, that info on sendfile makes sense for the fileserver situation.
> for webservers we will have to see (many/most CGI's look at stuff from the
> client so I still have doubts as to how much use cacheing will be)

CGI performance isn't directly affected by this - the whole point is to
reduce the "cost" of handling static requests to zero (at least, as close
as possible) leaving as much CPU as possible for the CGI to use.

So sendfile won't help your CGI directly - it will just give your CGI more
resources to work with.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
