Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314230AbSEITcC>; Thu, 9 May 2002 15:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314232AbSEITcB>; Thu, 9 May 2002 15:32:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35596 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314230AbSEITcA>;
	Thu, 9 May 2002 15:32:00 -0400
Message-ID: <3CDACE73.6692A31E@zip.com.au>
Date: Thu, 09 May 2002 12:30:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: indigoid@higherplane.net, dank@kegel.com, khttpd-users@alt.org,
        linux-kernel@vger.kernel.org
Subject: Re: khttpd rotten?
In-Reply-To: <20020509114009.GD3855@higherplane.net> <20020509.042938.78984470.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: john slee <indigoid@higherplane.net>
>    Date: Thu, 9 May 2002 21:40:09 +1000
> 
>    tux is more an application than an interface or mechanism.  applications
>    historically haven't been distributed as part of the main kernel tree.
> 
> Arguable nfsd is an application.
> 
> Providing a direct in-kernel link between the page cache and providing
> content (be it HTTP, FTP, NFS files, whatever) over sockets is a very
> powerful concept.

We want to expose all the zerocopy infrastructure to
userspace so all relevant applications can benefit.

The concern with moving one (major) application into the
kernel is that this will weaken the testing/motivation to get
zerocopy, aio and sophisticated notifications working well
for userspace.

Everyone who cares will end up implementing things as
TUX modules.

-
