Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbSLaF4j>; Tue, 31 Dec 2002 00:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbSLaF4j>; Tue, 31 Dec 2002 00:56:39 -0500
Received: from bitmover.com ([192.132.92.2]:11191 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267158AbSLaF4i>;
	Tue, 31 Dec 2002 00:56:38 -0500
Date: Mon, 30 Dec 2002 22:04:59 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Emiliano Gabrielli <emiliano.gabrielli@roma2.infn.it>,
       linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
Message-ID: <20021231060459.GA15558@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Emiliano Gabrielli <emiliano.gabrielli@roma2.infn.it>,
	linux-kernel@vger.kernel.org
References: <20021230122857.GG10971@wiggy.net> <200212301249.gBUCnXrV001099@darkstar.example.net> <20021230131725.GA16072@suse.de> <mailman.1041274740.23755.linux-kernel2news@redhat.com> <200212310528.gBV5Sbn29105@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212310528.gBV5Sbn29105@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2002 at 12:28:37AM -0500, Pete Zaitcev wrote:
> > IMHO and in my personal projects I use the following indenting rules:
> > 
> > 1) use TABs for _indentation_
> > 2) use SPACEs for aligning
> > 
> > here is an exaple:
> > 
> ><tab><tab>if (cond) {
> ><tab><tab><tab>dosometing;
> ><tab><tab><tab>printf("This is foo: '%s', and this bar: '%d'",
> ><tab><tab><tab>       foo, bar);
> 
> BTW, this practice is codified in Solaris developer's guidelines.
> They even have a perl script called "hdrchk" which is run before
> commits and tells about violations. Actually, the Sun requirement
> is to have exactly 4 spaces, but it sounds a little too anal to me.

Indeed and the reasoning is that tabs are for indentation, 4 spaces are
for continuation lines.

	if (expr) {
		statement;
		statement;
		if (really_long_expression && another_expression &&
		    one_more) {
		    	statement;
		}
	}

You can do slightly better than that if you do it like this:

		if (really_long_expression &&
		    another_expression && one_more) {
		    	statement;
		}
I try and get people to put the longer part of the expression on the
continuation line, your eyes will parse that better than the first way.

By the way, this sort of thing is a big deal around here, I spend a 
lot of time getting people to do it all the same way.  It's worth it.

The bottom line is "can I fix bugs in your code quickly?".  Indentation
is part of understanding the code.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
