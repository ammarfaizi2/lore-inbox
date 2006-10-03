Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbWJCIxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbWJCIxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 04:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWJCIxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 04:53:53 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:5901 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932543AbWJCIxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 04:53:52 -0400
Message-ID: <452224E7.9060105@symas.com>
Date: Tue, 03 Oct 2006 01:52:55 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060911 Netscape/7.2 (ax) Firefox/1.5 SeaMonkey/1.5a
MIME-Version: 1.0
To: John Graham-Cumming <antispam@jgc.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Spam, bogofilter, etc
References: <1159539793.7086.91.camel@mindpipe>  <20061002100302.GS16047@mea-ext.zmailer.org> <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org> <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org> <loom.20061003T100646-668@post.gmane.org>
In-Reply-To: <loom.20061003T100646-668@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Graham-Cumming wrote:
> Linus Torvalds <torvalds <at> osdl.org> writes:
>> I'm sorry, but spam-filtering is simply harder than the bayesian 
>> word-count weenies think it is. I even used to _know_ something about 
>> bayesian filtering, since it was one of the projects I worked on at uni, 
>> and dammit, it's not a good approach, as shown by the fact that it's 
>> trivial to get around.

> Have you actually followed any of the research into Bayesian (and similar
> machine learning based) anti-spam filtering, and attacks on such filters?  Are
> you making a claim that these filters are 'trivial to get around' based on a
> project you did at University over 10 years ago?

Well the recent spate of spams with technical/jargon keywords in their 
subjects was enough to make my Seamonkey client start marking all 
incoming mail as spam. Interesting that recent journals talk about this 
as an approach to get spam past current filters; instead it had a 
reverse effect.

So much for email management at our hosting provider. At least on my 
highlandsun.com domain I've got my own sendmail milter blocking spams 
before they get into the server. It's basically the equivalent of a 
sendmail accessdb in LDAP, plus simple rules to reject relays from 
unregistered IP addresses, or addresses with dynamically generated 
hostnames. Rejecting with 451 temporary failure is also useful, most 
bulk mailer programs fail immediately and go away. Real mail servers 
will retry; by looking at the logs of the envelope FROM and RCPT I can 
pick out any emails that should have been let thru and add an OK 
exception to LDAP so the message eventually gets redelivered. I suppose 
I could put a URL in the reject error message, and let the sender 
confirm it from there. At this point the only spam that gets thru is 
from dedicated mass marketers with legitimate DNS registrations and I 
just manually add their subnets to my blacklist.

(One then is faced with the interesting question - what if someone from 
one of those companies was actually trying to hire my services? Their 
loss I guess, sometimes money really is tainted...)
-- 
   -- Howard Chu
   Chief Architect, Symas Corp.  http://www.symas.com
   Director, Highland Sun        http://highlandsun.com/hyc
   OpenLDAP Core Team            http://www.openldap.org/project/
