Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbUDAMPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 07:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbUDAMPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 07:15:24 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:18862 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262880AbUDAMPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 07:15:22 -0500
Date: Thu, 1 Apr 2004 14:14:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: [discuss] Re: [CFT] inflate.c rework arch testing needed
Message-ID: <20040401121417.GA8185@wohnheim.fh-wedel.de>
References: <20040318231006.GK11010@waste.org> <20040319003252.GB11450@wohnheim.fh-wedel.de> <20040319030942.GM11010@waste.org> <20040328070015.GB1453@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040328070015.GB1453@openzaurus.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 March 2004 09:00:15 +0200, Pavel Machek wrote:
> 
> > The code for new versions of zlib is significantly scarier last I
> > checked and there's no particular advantage to it. But one of the
> > primary motivations here is to get to the point where something like
> > bunzip2 or even a new zlib is a drop-in replacement.
> 
> Some people want fast-but-not-big-ratio compressor for speeding up swsusp.
> If compressors are drop-in, thats very good.

Also keep in mind, which zlib you are talking about.  Matt's patch is
to lib/inflate.c, which is used exclusively for the bootloader which
is built-in to the kernel on some arches.  That one was always far
behind and scary to look at.

The real kernel zlib is in a somewhat better state, many people cared
about and worked on it.  It's not great either, but at least better.
And yes, drop-in replacement or even runtime choice would be nice here.

Jörn

-- 
The story so far:
In the beginning the Universe was created.  This has made a lot
of people very angry and been widely regarded as a bad move.
-- Douglas Adams?
