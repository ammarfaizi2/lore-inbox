Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbTE0X1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbTE0X1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:27:22 -0400
Received: from dp.samba.org ([66.70.73.150]:64673 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264442AbTE0X1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:27:19 -0400
Date: Wed, 28 May 2003 09:40:39 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: "John T. Guthrie" <guthrie@counterexample.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] reading /proc/hermes/eth1/recs causes an oops in 2.5.69
Message-ID: <20030527234039.GA20861@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	"John T. Guthrie" <guthrie@counterexample.org>,
	linux-kernel@vger.kernel.org
References: <200305270803.h4R83dMc010911@gauss.counterexample.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305270803.h4R83dMc010911@gauss.counterexample.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, May 27, 2003 at 04:03:39AM -0400, John T. Guthrie wrote:
> Hello all,
> 
> I'm currently running Red Hat linux 8.0 on my Inspiron 8100 laptop.  Last
> night, I decided to check out a recent 2.5 kernel.  While wandering around
> in the /proc filesystem, I came across /proc/hermes/eth1/recs.  From what I
> had seen in under 2.4.21-pre4, it should have just given me a whole bunch of
> interesting information about my wireless card.  Instead, just attempting to
> read the file caused an oops.  After the initial oops, the machine wasn't
> completely unresponsive, I could still press the keyboard one more time to
> generate yet another oops, but then the machine would be completely
> unresponsive and had to be power cycled.

Doesn't surprise me all that much - there are a lot of bugs in 0.13a,
the driver version in 2.5.69.

In 0.13e, the latest version, the /proc support has been abolished in
favour of a simpler debugging hack.  I intend to retransmit a patch to
update the driver today.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
