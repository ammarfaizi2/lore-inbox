Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317052AbSEXIeP>; Fri, 24 May 2002 04:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSEXIeO>; Fri, 24 May 2002 04:34:14 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:23781 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317052AbSEXIeO> convert rfc822-to-8bit; Fri, 24 May 2002 04:34:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
Date: Fri, 31 May 2002 10:34:33 +0200
X-Mailer: KMail [version 1.4]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20020524071657.GI21164@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205311034.33771.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> as far I can see that negative dentries are not caching anything, they
> should be dropped immediatly, they even slowdown the lookups because
> they're hashed.

They cache things like this:
open("/usr/lib/locale/de_DE+euro/LC_MEASUREMENT", O_RDONLY) = -1 ENOENT (No 
such file or directory)
open("/usr/lib/locale/de_DE@euro/LC_MEASUREMENT", O_RDONLY) = 3

Thus they are not really useless, they are just not usefully limited.
Thus IMHO you should look at the swap out path.

	Regards
		Oliver

