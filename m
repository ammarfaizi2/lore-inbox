Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVCJRSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVCJRSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVCJRQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:16:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43422 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262729AbVCJROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:14:00 -0500
Subject: Re: [PATCH] make st seekable again
From: Arjan van de Ven <arjan@infradead.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1050310114027.11549B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1050310114027.11549B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 18:13:53 +0100
Message-Id: <1110474834.6291.114.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 11:56 -0500, Bill Davidsen wrote:
> On Thu, 10 Mar 2005, Arjan van de Ven wrote:
> 
> > >  critical user data.
> > > 
> > > In other words, it should work correctly or not at all. At the least this
> > > should be a config option, like UNSAFE_TAPE_POSITIONING or some such.
> > > And show the option if the build includes BROKEN features. That should put
> > > the decision where it belongs and clarify the possible failures.
> > 
> > CONFIG_SECURITY_HOLES doesn't make sense.
> > Better to just fix the security holes instead.
> 
> I think you're an idealist. If this were something other than tar it would
> be simple, and you would be right. Well, you ARE right, but a change which
> breaks tar, which many sites use for backups, is really not practical,
> without a loophole until tar gets fixed. And as Alan noted, keeping track
> of the physical position is very hard, and getting a tar fix might take a
> while.
> 

No the problem is that the *st* code has a security hole. THAT is the
problem. Not that it would be seekable. But how it implements the seeks.
THAT part is the problem. And THAT can be fixed. 

