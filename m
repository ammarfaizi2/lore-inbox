Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268107AbTBSAeF>; Tue, 18 Feb 2003 19:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268112AbTBSAeF>; Tue, 18 Feb 2003 19:34:05 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4736 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S268107AbTBSAeE>;
	Tue, 18 Feb 2003 19:34:04 -0500
Date: Tue, 18 Feb 2003 16:43:31 -0800
From: Bob Miller <rem@osdl.org>
To: Oleg Drokin <green@namesys.com>
Cc: John Cherry <cherry@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.61
Message-ID: <20030219004331.GA1458@doc.pdx.osdl.net>
References: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com> <1045510507.3406.12.camel@cherrypit.pdx.osdl.net> <20030218151407.A14679@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218151407.A14679@namesys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 03:14:07PM +0300, Oleg Drokin wrote:
> Hello!
> 
> On Mon, Feb 17, 2003 at 11:35:07AM -0800, John Cherry wrote:
> 
> > Warning summary
> [...]
> >    fs/reiserfs: 1 warnings, 0 errors
> 
> Note that this warning comes from asm/string.h, when compiling
> fs/reiserfs/prints.c
> Warning itself is "strchr is defined but not used". It have nothing
> to do with reiserfs at all. And I do not see why it is produced at all, since
> strchr is declared "static inline".
> (BTW, gcc 2.95 does not produces the warning).
> Can somebody look at it please?
> 
> Bye,
>     Oleg
I spent a little time looking at this weeks ago.  I compiled the file
-E to see what the pre-processor was doing.  I then tried to compile
the pre-processed file and the warning went away.  So, it looks to me
like some kind of compiler error with the way it pre-processes files
(at that point the problem got a lot less interesting ;-).

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
