Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTFJIPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 04:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTFJIPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 04:15:51 -0400
Received: from userk185.dsl.pipex.com ([62.188.58.185]:33432 "HELO
	userk185.dsl.pipex.com") by vger.kernel.org with SMTP
	id S262444AbTFJIPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 04:15:50 -0400
From: "Sean Hunter" <sean@uncarved.com>
Date: Tue, 10 Jun 2003 08:29:30 +0000
To: Shawn <core@enodev.com>
Cc: Matthias Schniedermeyer <ms@citd.de>,
       "Leonardo H. Machado" <leoh@dcc.ufmg.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cachefs on linux
Message-ID: <20030610082930.GA26777@uncarved.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>, Shawn <core@enodev.com>,
	Matthias Schniedermeyer <ms@citd.de>,
	"Leonardo H. Machado" <leoh@dcc.ufmg.br>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306091624370.14854-100000@volga.dcc.ufmg.br> <20030609204249.GA11373@citd.de> <1055191776.13435.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055191776.13435.6.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 03:49:36PM -0500, Shawn wrote:
> Well, it's a nice way to simulate writing on r/o filesystems IIRC. Like
> mounting a cdrom then writing to it, but you're not.
> 
> Was that was this was? Anyway, linux also does not have unionFS. If it
> was that big of a deal, someone would write it. As it is, it's a
> whizbang no one cares about enough.

Its particularly handy for fast read-only NFS stuff.  We have thousands
of linux hosts and distributing software to all of them is a pain.  With
cachefs with NFS as the "back" filesystem, you push to the masters and
the clients get the changes over NFS and then store them in their local
cache so your software distribution nightmare becomes no problem at all.
Clients read off the local disk if they can, but fetch over NFS as
required.  You can tune the cache size on all of the client machines so
they can cache more or less of the most recently used NFS junk on its
local disk.

Sean
