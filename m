Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317913AbSGWCPo>; Mon, 22 Jul 2002 22:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317921AbSGWCPo>; Mon, 22 Jul 2002 22:15:44 -0400
Received: from bitmover.com ([192.132.92.2]:15792 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S317920AbSGWCPm>;
	Mon, 22 Jul 2002 22:15:42 -0400
Date: Mon, 22 Jul 2002 19:17:23 -0700
From: Larry McVoy <lm@bitmover.com>
To: Dave Jones <davej@suse.de>, Thomas Molina <tmolina@cox.net>,
       linux-kernel@vger.kernel.org,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       Rik van Riel <riel@conectiva.com.br>
Cc: Wayne Scott <wscott@bitmover.com>
Subject: Re: bug database/webpage
Message-ID: <20020722191723.C10973@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dave Jones <davej@suse.de>, Thomas Molina <tmolina@cox.net>,
	linux-kernel@vger.kernel.org,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Wayne Scott <wscott@work.bitmover.com>
References: <Pine.LNX.4.44.0207221547360.19736-100000@dad.molina> <20020722233119.R27749@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020722233119.R27749@suse.de>; from davej@suse.de on Mon, Jul 22, 2002 at 11:31:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 11:31:19PM +0200, Dave Jones wrote:
>  > http://members.cox.net/tmolina
>  > 
>  > Would something like this be sufficient, or would a full-fledged server be 
>  > required?  Feedback/comments are welcome
> 
> Quite nice. It's a more organised version of what I had, but as the
> number of reports gets higher and higher, it could end up being as much a
> maintainence nightmare as the log I was updating.
> 
> Talking with a few folks about this problem at the summit, a few times
> jitterbug was mentioned. My faded memory doesn't recall too much about
> those days, but ultimatly it didn't work out.
> 
> I'm wondering how such a system would work out today.
> There's even possibilites for neat things like checking
> bitkeeper to automatically update status when Linus applies
> a patch, which before required interaction from Linus.

We have a bug database pretty close to being ready be shipped.  It's a 
somewhat "unique" approach, we figured out how to coax a BK repository
into looking like a database and added a layer so you can spit pseudo
SQL queries at the repository and get bug reports.  You can play with 
it at http://bitkeeper.bkbits.net/bugs.html which is actually our
live bug database so don't close bugs unless you fixed them :)

Part of the point of doing it as a BK repository was that you could
take your bugdb with you and link bugs to changesets as you create
the changesets.  If people do that, the release notes which list the
set of bugs closed by that release can be generated with a one line
command, which is a big part of what people want.

For those people who'd rather roll their own than use ours, the linkage
is done through the use of "changeset keys" which are the underlying name
for revisions.  You can dig those out with a

	"bk prs -r<rev> -nd:KEY: ChangeSet"

and there is a key2rev command which will convert them back if you like.

We can easily import any format so long as we can get at the data so if
a bugdb emerges which has the data and people no longer want to maintain
it, we'll do the import.  

Regardless of what database is used, we can provide a machine, net
connection, etc.  I think the person who did that page mentioned that
their ISP wouldn't let them host it.  If you want a kbugs.bkbits.net or
some other name, let me know, I'll get someone to set it up.  It won't
be the biggest machine in the world, probably a 400Mhz bookpc, but the
bugdb would be the only thing on it so it might be enough.  If it's not,
we'll revisit the issue.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
