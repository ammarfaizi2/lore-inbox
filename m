Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264430AbTCXVxl>; Mon, 24 Mar 2003 16:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264431AbTCXVxh>; Mon, 24 Mar 2003 16:53:37 -0500
Received: from bitmover.com ([192.132.92.2]:24215 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264430AbTCXVxd>;
	Mon, 24 Mar 2003 16:53:33 -0500
Date: Mon, 24 Mar 2003 14:04:35 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, lm@bitmover.com,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
Message-ID: <20030324220435.GA11421@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, lm@bitmover.com,
	venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com> <20030324200105.GA5522@work.bitmover.com> <543480000.1048540161@flay> <20030324153602.28b44e23.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324153602.28b44e23.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 03:36:02PM -0800, Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> >
> > On a slightly related note, I played with lmbench a bit over the weekend,
> > but the results were too unstable to be useful ... they're also too short
> > to profile ;-( 
> > 
> > I presume it does 100 iterations of a test (like fork latency?). Or does 
> > it just do one? Can I make it do 1,000,000 iterations or something
> > fairly easily ? ;-) I didn't really look closely, just apt-get install
> > lmbench ... 
> 
> Yes, that is something I've wanted several times.  Just a way to say "run
> this test for ever so I can profile the thing".
> 
> Even a sleazy environment string would suffice.

It's been there, I suppose you need to read the source to figure it out
though the lmbench script also plays with this I believe.

work ~/LMbench2/bin/i686-pc-linux-gnu ENOUGH=1000000 time bw_pipe
Pipe bandwidth: 655.37 MB/sec
real    0m23.411s
user    0m0.480s
sys     0m1.180s

work ~/LMbench2/bin/i686-pc-linux-gnu time bw_pipe
Pipe bandwidth: 809.81 MB/sec

real    0m2.821s
user    0m0.480s
sys     0m1.180s


-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
