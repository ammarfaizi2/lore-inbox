Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbTAATb6>; Wed, 1 Jan 2003 14:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbTAATb6>; Wed, 1 Jan 2003 14:31:58 -0500
Received: from bitmover.com ([192.132.92.2]:6888 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261561AbTAATb5>;
	Wed, 1 Jan 2003 14:31:57 -0500
Date: Wed, 1 Jan 2003 11:40:19 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hanna Linder <hannal@us.ibm.com>, Eli Carter <eli.carter@inet.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Raw data from dedicated kernel bug database
Message-ID: <20030101194019.GZ5607@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Hanna Linder <hannal@us.ibm.com>, Eli Carter <eli.carter@inet.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What are the chances that the raw data from the kernel bugdb could be
made available?  I bet Bradford wants it and I know I want.  We are 
working on an integrated bugdb for BitKeeper and it would be cool if
we could track the real db at osdl.  

The advantage of having the data available is that for the BK kernel
users we could give them access to the bugdb while they are doing 
checkins so that the developers link the changes to the bugs as they
do the fixes, which is a good time to do it.  

To calm any fears that we are trying to take over the bugdb, we're not.
We just want to track it.  Any changes made in a BK bugdb are trivially
exportable to an external format and if the need arises we'll work with
IBM/OSDL to make that happen.  In fact, we can automate it.


Getting back to the data, the ideal raw data format for us would be

	for bug in `cat list-o-bugs`
	do	for field in `cat list-o-fields`
		do	extract $field from $bug into $bug.$field
			set-timestamp \
			    of $bug.$field \
			    to date that $bugd.$field was created/updated
		done
	done

I'm not sure if the fields are all self-contained.  For example, the updates
are done by someone, is that someone part of the data or is it "metadata".
What about state transitions (open -> closed)?

The other alternative is to make the whole infrastructure available as 
tarball, the mysql db et al, so that someone could slurp that down and
poke at it locally.

Any chance of this?  I'd much appreciate it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
