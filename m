Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUHHV4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUHHV4r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 17:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbUHHV4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 17:56:46 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:49838 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S265087AbUHHV4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 17:56:33 -0400
Subject: Re: What PM should be and do (Was Re: Solving suspend-level
	confusion)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20040808165416.GB2668@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408031928.08475.david-b@pacbell.net> <1091588163.5225.77.camel@gaston>
	 <200408032030.41410.david-b@pacbell.net>
	 <1091594872.3191.71.camel@laptop.cunninghams>
	 <1091595224.1899.99.camel@gaston>
	 <1091595545.3303.80.camel@laptop.cunninghams>
	 <20040808165416.GB2668@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092002119.6215.7.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 09 Aug 2004 07:55:19 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-08-09 at 02:54, Pavel Machek wrote:
> Hi!
> 
> > Yes. I'm not trying to give drivers an inconsistent state, just delaying
> > suspending some until the last minute....
> > 
> > Suspend 2 algorithm:
> > 
> > 1. Prepare image (freeze processes, allocate memory, eat memory etc)
> > 2. Power down all drivers not used while writing image
> > 3. Write LRU pages. ('pageset 2')
> > 4. Quiesce remaining drivers, save CPU state, to atomic copy of
> > remaining ram.
> > 5. Resume quiesced drivers.
> 
> Hmm, this means pretty complex subtree handling.. Perhaps it would be
> possible to make "quiesce/unquiesce" support in drivers so that this
> is not needed?

That would be great from my point of view. It's why I talked before in
terms of quiesced etc rather than S3, S4 and so on.

Nigel

