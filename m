Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbTEaRAz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 13:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTEaRAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 13:00:55 -0400
Received: from miranda.zianet.com ([216.234.192.169]:27143 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264380AbTEaRAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 13:00:54 -0400
Subject: Re: coding style (was Re: [PATCH][2.5] UTF-8 support in console)
From: Steven Cole <elenstev@mesatop.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Chris Heath <chris@heathens.co.nz>, linux-kernel@vger.kernel.org
In-Reply-To: <20030531153940.GA1280@work.bitmover.com>
References: <20030531095521.5576.CHRIS@heathens.co.nz>
	 <20030531152133.A32144@infradead.org>
	 <20030531144323.GA22810@work.bitmover.com> <20030531150150.GA14829@suse.de>
	 <20030531153940.GA1280@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054401248.2900.124.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 31 May 2003 11:14:08 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-31 at 09:39, Larry McVoy wrote:
> On Sat, May 31, 2003 at 04:01:50PM +0100, Dave Jones wrote:
> > Saving a line over readability is utterly bogus.
> 
> I agree 100%.  If you have anything more complex than
> 
> 	if (error) return (error);
> 
> I want it to look like
> 	
> 	if ((expr) || (expr2) || (expr3)) {
> 		return (error);
> 	}
> 
This may just be pedantic minutiae, but aren't those parenthesis around
"error" unnecessary?

Here is a proposal for coding style: Only use parenthesis in the return
statement when needed.

return -ETOSENDERADDRESSUNKNOWN;	/* this is OK */
return (value & ZORRO_MASK);		/* so is this */
return (-ENOTENOUGHCOFFEE);		/* bogus parenthesis */ 

Steven

