Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266433AbSKOQ0E>; Fri, 15 Nov 2002 11:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbSKOQ0E>; Fri, 15 Nov 2002 11:26:04 -0500
Received: from bitmover.com ([192.132.92.2]:62365 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266408AbSKOQ0C>;
	Fri, 15 Nov 2002 11:26:02 -0500
Date: Fri, 15 Nov 2002 08:32:47 -0800
From: Larry McVoy <lm@bitmover.com>
To: Khoa Huynh <khoa@us.ibm.com>
Cc: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       mbligh@aracnet.com
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <20021115083247.F32321@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Khoa Huynh <khoa@us.ibm.com>, Larry McVoy <lm@bitmover.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	linux-kernel-owner@vger.kernel.org, mbligh@aracnet.com
References: <OF13B0B9E1.574AFCAA-ON85256C72.00595C26@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF13B0B9E1.574AFCAA-ON85256C72.00595C26@pok.ibm.com>; from khoa@us.ibm.com on Fri, Nov 15, 2002 at 10:23:19AM -0600
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 10:23:19AM -0600, Khoa Huynh wrote:
> Yes, this is great!  We can create a separate field in the bug reports to
> contain this unique names, so we can reference the cset directly from
> the bug reports.  This allows us to link bug reports to csets -- great!
> 
> What format will these unique names be in?  If we put them in the bug
> reports,
> can we click on them (as URLs) and get to the csets directly?

That's the goal.  I'm hacking on it it currently, we have some issues with
how it works today, I'll try and get a bk-3.0.1 release out the door which
fixes them.  

The current format is may be seen with a 

	bk changes -k -r<rev>

where <rev> is the changeset revision you want.  You'll get something like
this:

	torvalds@home.transmeta.com|ChangeSet|20021115061315|00914

That's sort of big and ugly, and it currently doesn't work as a name
in BK/Web.  I'm debugging an implementation of md5 sums of the above
to see if we can use that instead.  I'll let you know as soon as I
have something which works.  

Assuming that we get some format like dSD4okOiGmLGDcqOTpQPFQ== then 
you'll be able to view the cset with the following URL

	http://linux.bkbits.net:8080/linux-2.5/cset@dSD4okOiGmLGDcqOTpQPFQ==

and that will always work and never get you different data.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
