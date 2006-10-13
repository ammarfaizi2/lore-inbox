Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWJMQwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWJMQwJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWJMQwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:52:09 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:29578 "EHLO
	biscayne-one-station.mit.edu") by vger.kernel.org with ESMTP
	id S1751383AbWJMQwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:52:06 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Adam Belay <abelay@MIT.EDU>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <1160759349.25218.62.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	 <1160753187.25218.52.camel@localhost.localdomain>
	 <1160753390.3000.494.camel@laptopd505.fenrus.org>
	 <1160755562.25218.60.camel@localhost.localdomain>
	 <1160757260.26091.115.camel@localhost.localdomain>
	 <1160759349.25218.62.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 13:01:22 -0400
Message-Id: <1160758883.26091.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.217
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 18:09 +0100, Alan Cox wrote:
> Ar Gwe, 2006-10-13 am 12:34 -0400, ysgrifennodd Adam Belay:
> > I agree this needs to be fixed.  However, as I previously mentioned,
> > this isn't the right place to attack the problem.  Remember, this wasn't
> > originally a kernel regression.  Rather it's a workaround for a known
> 
> It's a kernel regression. It used to be reliable to read X resource
> addresses at any time.

Not true, reading these registers during a BIST has always been a
problem.

> 
> > Finally, it's worth noting that this issue is really a corner-case, and
> > in most systems it's extremely rare that even incorrect userspace apps
> > would have any issue.
> 
> Except just occasionally and randomly in the field, probably almost
> undebuggable and irreproducable - the very worst conceivable kind of
> bug.
> 

Which is why returning an error code during device transitions is a
reasonable compromise between correctness and practicality.

-Adam


