Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVA0LRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVA0LRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVA0LQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:16:18 -0500
Received: from canuck.infradead.org ([205.233.218.70]:26378 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262567AbVA0LNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:13:43 -0500
Subject: Re: Patch 1/6  introduce sysctl
From: Arjan van de Ven <arjanv@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <m1mzuv40ro.fsf@muc.de>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101201.GB9760@infradead.org>  <m1mzuv40ro.fsf@muc.de>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 12:13:33 +0100
Message-Id: <1106824413.5624.76.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 11:36 +0100, Andi Kleen wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> > This first patch of the series introduces a sysctl (default off) that
> > enables/disables the randomisation feature globally. Since randomisation may
> > make it harder to debug really tricky situations (reproducability goes
> > down), the sysadmin needs a way to disable it globally.
> 
> A global sysctl doesn't make much sense to me for this. If you
> want to get some program running you don't want to impact your
> system daemons. And a non root user couldn't enable it anyways,
> which can be annoying if it is needed to get some binary working.
> 
> If anything I would make it a personality flag so that it can
> be set per process.

I actually wanted both; eg a global "whack it off" and a per process
flag for all the reasons you state. 
I have no objection to remove the global "whack it off" flag, however,
for testing this stuff in -mm it might be useful to have a simple "turn
it off" option.


