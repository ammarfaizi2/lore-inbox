Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbTHaKNP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 06:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbTHaKNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 06:13:15 -0400
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:64134 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S262544AbTHaKNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 06:13:13 -0400
Date: Sun, 31 Aug 2003 12:13:11 +0200
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831101309.GA5764@hout.vanvergehaald.nl>
References: <20030830012949.GA23789@work.bitmover.com> <20030830150311.GB23789@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830150311.GB23789@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 08:03:11AM -0700, Larry McVoy wrote:
> On Fri, Aug 29, 2003 at 06:29:49PM -0700, Larry McVoy wrote:
> 
> > We've avoiding turning on that feature in the past because we
> > share the T1 line that bkbits.net lives on with all the rest of
> > bitmover and we are partialy a distributed company.  We do VOIP
> > phones and when you guys clone a repo our phones don't work -
> > that makes us look bad during a sales call.
> 
> Many people have sent me mail saying that we should be using
> traffic shaping to fix this problem.  We are using it and we can't
> seem to make it work.  Our theory is that we have a network like
> 
>  ----- [ ISP ] ====== internet ======== [ ISP ] ----
> 
> wherein "-" means our skinny T1 or DSL and "=" means some fat
> internet connection on the backbone.
> 
> We can shape all we want on our ends but if the internet is
> blasting us then our skinny pipe gets full and our shaping doesn't
> work.  We really need to have the ISP do the shaping so they can
> squelch the traffic before it gets to our pipe.
> 
> If there is someone out there who (a) is running VOIP over the
> public net to a pile of different end points (T1 on both ends tends
> to work, T1 to DSL or cable modem tends to get harder) and (b) has
> figured out traffic shaping that works I'd love to know about it.

We are using a Packetshaper box from Packeteer (www.packeteer.com).
It solves the problem you are describing (shaping the incoming traffic)
by ajusting the windowsize in the outgoing acknowledgements, if I'm not
mistaken.  It has done miracles for us.

Could Linux do this?

(Sorry for the plug. I don't have stocks in the company, nor am I
involved with them in any other way. We are just a happy customer.)

> But just saying QoS/wondershaper doesn't help much (though the
> thought is appreciated), we've tried that already.
> 
> Thanks.
> -- 
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

Regards,
Toon.
