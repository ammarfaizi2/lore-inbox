Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbTH3PDY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 11:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTH3PDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 11:03:24 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:44980 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264891AbTH3PDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 11:03:14 -0400
Date: Sat, 30 Aug 2003 08:03:11 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030830150311.GB23789@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030830012949.GA23789@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830012949.GA23789@work.bitmover.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 06:29:49PM -0700, Larry McVoy wrote:
> We've avoiding turning on that feature in the past because we share the
> T1 line that bkbits.net lives on with all the rest of bitmover and we are
> partialy a distributed company.  We do VOIP phones and when you guys clone
> a repo our phones don't work - that makes us look bad during a sales call.

Many people have sent me mail saying that we should be using traffic
shaping to fix this problem.  We are using it and we can't seem to make
it work.  Our theory is that we have a network like

 ----- [ ISP ] ====== internet ======== [ ISP ] ----

wherein "-" means our skinny T1 or DSL and "=" means some fat internet 
connection on the backbone.  

We can shape all we want on our ends but if the internet is blasting us
then our skinny pipe gets full and our shaping doesn't work.  We really
need to have the ISP do the shaping so they can squelch the traffic 
before it gets to our pipe.

If there is someone out there who (a) is running VOIP over the public net
to a pile of different end points (T1 on both ends tends to work, T1 to DSL
or cable modem tends to get harder) and (b) has figured out traffic shaping
that works I'd love to know about it.  

But just saying QoS/wondershaper doesn't help much (though the thought is
appreciated), we've tried that already.

Thanks.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
