Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTLUWSU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 17:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTLUWSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 17:18:20 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:44434 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264144AbTLUWST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 17:18:19 -0500
Subject: Re: [PATCH] loop.c patches, take two
From: Christophe Saout <christophe@saout.de>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Ben Slusky <sluskyb@paranoiacs.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, jariruusu@users.sourceforge.net
In-Reply-To: <3FE6076B.3090908@kolumbus.fi>
References: <20031030134137.GD12147@fukurou.paranoiacs.org>
	 <3FA15506.B9B76A5D@users.sourceforge.net>
	 <20031030133000.6a04febf.akpm@osdl.org>
	 <20031031005246.GE12147@fukurou.paranoiacs.org>
	 <20031031015500.44a94f88.akpm@osdl.org>
	 <20031101002650.GA7397@fukurou.paranoiacs.org>
	 <20031102204624.GA5740@fukurou.paranoiacs.org>
	 <20031221195534.GA4721@fukurou.paranoiacs.org>
	 <3FE6076B.3090908@kolumbus.fi>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1072044101.18969.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Dec 2003 23:01:41 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 21.12.2003 schrieb Mika Penttilä um 21:49:

> Yet another Big Loop Patch... :)
> 
> It's not obvious which parts are bug fixes, and which performance 
> improvements. What exactly breaks loops on journalling filesystems, and 
> how do you solve it?

What about dropping block device backed support for the loop driver
altogether? We now have a nice device mapper in the 2.6 kernel. I don't
like the schizophrenic way the loop driver handles these things (and
you'll always run into similar trouble when trying to fix or resolve
this issue). I know this is kind of radical... but everyone loves
radical ideas. ;)

There also a new device mapper target dm-crypt I've written some time
ago, which does basically the same cryptoloop is doing (or tries to do,
whatever ;)) and which seems to work quite well.

I've never had any feedback from the kernel maintainers about including
it into the main kernel. Andrew?

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

