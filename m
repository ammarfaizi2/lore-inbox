Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTABCIR>; Wed, 1 Jan 2003 21:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbTABCIQ>; Wed, 1 Jan 2003 21:08:16 -0500
Received: from bitmover.com ([192.132.92.2]:16263 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265414AbTABCIP>;
	Wed, 1 Jan 2003 21:08:15 -0500
Date: Wed, 1 Jan 2003 18:16:37 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Timothy D. Witham" <wookie@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@zip.com.au>,
       Dave Jones <davej@codemonkey.org.uk>, Randy Dunlap <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Raw data from dedicated kernel bug database
Message-ID: <20030102021637.GA23419@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Timothy D. Witham" <wookie@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@zip.com.au>,
	Dave Jones <davej@codemonkey.org.uk>,
	Randy Dunlap <rddunlap@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030101194019.GZ5607@work.bitmover.com> <12310000.1041456646@titus> <20030101221510.GG5607@work.bitmover.com> <1041473017.22606.8.camel@irongate.swansea.linux.org.uk> <1041467938.1541.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041467938.1541.2.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Tim!

On Wed, Jan 01, 2003 at 04:38:58PM -0800, Timothy D. Witham wrote:
>   The data is there for everybody.  As long as we can automate the
> extraction I don't see any issue with multiple people extracting
> and using with other tools.  Data and manure only work if you
> can spread it around.

That is a great quote, mind if I stick on my quotes page?

>   My opinion is that the more uses of the data the better.  So
> the question is, "What does Larry need to make this happen?".

If your guys are too busy to figure out how to do this, since I'm asking
you to do something for me, how about they give me a snapshot of the 
DB's, I'll get one of my guys to tinker with it enough that they can
get the data out, and then we'll provide a script to do this on an
ongoing basis.  So you could run

	cd /home/bugme
	make export

out of cron and it would serve up a tarball that anyone could eat.
Anyone else who is interested in the data can contact me with their
desired export format and I'm merge sort over the requests.  If 
nobody cares then what I'd create is a directory tree that looked 
like:

	bugdb/
	    bugs/
		MM-YYYY/
		    bug1.field1
		    bug1.field2
		    ...
		    bug1.fieldN
		    bug2.field1
		    bug2.field2
		    ...
		    bug2.fieldN
		    ...
	    users/
		user1.field1
		...
		user1.fiendN
		user2.field1
		...
		user2.fiendN
		...

In other words, a zillion little files, a cluster of files per bugid,
with each file in the cluster representing a field in the bug.  That
way there are no parse/unparse issues (if we used XML then we need to
unXML it to get it into some other DB).  Each MM-YYYY directory is
used to store all bugs created in that month (so we don't end up with
one directory with 10 million files in it).

It wastes tons of space because there will be zillions of these files
but it's a tarball and it's only for import/export.  And it has to be
the most neutral format.

How's that sound?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
