Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266563AbUBMKlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUBMKlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:41:07 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:42902 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266563AbUBMKlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:41:03 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Date: Fri, 13 Feb 2004 18:50:41 +0800
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Giuliano Pochini <pochini@shiny.it>,
       linux-kernel@vger.kernel.org
References: <200402130615.10608.mhf@linuxmail.org> <200402131749.19758.mhf@linuxmail.org> <402CA267.4090202@cyberone.com.au>
In-Reply-To: <402CA267.4090202@cyberone.com.au>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402131850.41339.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 18:09, Nick Piggin wrote:
> 
> Michael Frank wrote:
> 
> >On Friday 13 February 2004 17:10, Andrew Morton wrote:
> >
> >>
> >>Yes, 80 cols sucks and the world would be a better place had CodingStyle
> >>mandated 96 columns five years ago.  But it didn't happen.
> >>
> >>
> >
> >As to "five years ago", what about review the coding style situation before 
> >starting 2.7:
> >
> >In view of better hardware, increasing linelength a little to 96 could be 
> >considered without increasing the number of indentation levels.
> >
> >
> 
> I hope not, I usually use 80 columns. Email's using 80 columns.
> And lines start becoming difficult for the eyes to follow as they
> get longer. Maybe this isn't so much a problem with C code due to
> indentation and the sparseness of the lines.
> 

Just for consideration and nesting should _not_ be increased ;)

80 is quite OK but has not much margin and is asking for more lines
times with nesting of 3.	

0	1	2	3	4					        |<81
	
		printk(KERN_WARNING "Warning this is a long printk with "
						"3 parameters a: %u b: %u "
						"c: %u \n", a, b, c);
		next_statement;

		printk(KERN_WARNING "Warning this is a long printk with "
			"3 parameters a: %u b: %u "c: %u \n", a, b, c);
		next_statement;

96 is not excessive and will reduce linecount and often makes things more readable.

0	1	2	3	4								|<97

		printk(KERN_WARNING "Warning this is a long printk with 3 parameters "
							"a: %u b: %u "c: %u \n", a, b, c);
		next_statement;


