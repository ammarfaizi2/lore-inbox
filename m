Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129932AbRCAVYw>; Thu, 1 Mar 2001 16:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130043AbRCAVYn>; Thu, 1 Mar 2001 16:24:43 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:56591 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129932AbRCAVYg>; Thu, 1 Mar 2001 16:24:36 -0500
Message-ID: <3A9EBDF4.57C769AF@transmeta.com>
Date: Thu, 01 Mar 2001 13:24:04 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Pavel Machek <pavel@suse.cz>, Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
In-Reply-To: <Pine.GSO.4.21.0103011608360.11577-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> I _really_ don't want to trust the ability of shell to deal with long
> command lines. I also don't like the failure modes with history expansion
> causing OOM, etc.
> 
> AFAICS right now we hit the kernel limit first, but I really doubt that
> raising said limit is a good idea.
> 

Arbitrary limits are generally bad.  Yes, using a very long command line
is usually a bad idea, but there are cases for which it is the only
reasonable way to do something.  Categorically blocking them is not a
good idea either.

> xargs is there for purpose...

Well, yes; using xargs is a good idea, not the least because it enables
some parallelism that wouldn't otherwise be there.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
