Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274877AbTGaVfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274875AbTGaVd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:33:57 -0400
Received: from AMarseille-201-1-5-189.w217-128.abo.wanadoo.fr ([217.128.250.189]:30759
	"EHLO gaston") by vger.kernel.org with ESMTP id S269623AbTGaVdL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:33:11 -0400
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@suse.cz>, Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <3F2952B1.6060805@pacbell.net>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org>
	 <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net>
	 <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net>
	 <20030731094231.GA464@elf.ucw.cz> <3F291B9E.10109@pacbell.net>
	 <20030731140908.GB16463@atrey.karlin.mff.cuni.cz>
	 <3F2952B1.6060805@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059687143.2417.166.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 31 Jul 2003 23:32:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If it's in the middle of any kind of write, suspending would
> seem to be unwise.  Say, writing to a swap partition...

No, you wait for pending requests to complete and keep further
ones in the queue. I will probably write the proper infrastructure
for SCSI hosts later this month, it has to be done like IDE, with
a special BIO "suspend" request so that things gets properly
synchronized.

> Mostly I'm just saying that if vetoing ever makes sense
> (and I understand that it does), USB drivers will need
> to understand it too.
> 
> - Dave
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
