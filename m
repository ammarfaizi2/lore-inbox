Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVADDHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVADDHa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 22:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVADDHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 22:07:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46312 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261976AbVADDHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 22:07:23 -0500
Date: Tue, 4 Jan 2005 03:07:17 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ZP Gu <zpg@castle.net>
Subject: Re: [PATCH][RFC] clean out old cruft from FD MCS driver
Message-ID: <20050104030717.GQ18080@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.61.0501032350040.3529@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501032350040.3529@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 12:11:27AM +0100, Jesper Juhl wrote:
> At this point I got the feeling that this driver had been left to rot and 
> I desided to see if there was more cruft in there that we might as well 
> get rid of, and indeed there is.

Yup.  There's a lot of cruft in that driver.  I really don't like the
look of fd_mcs_intr() -- trying to deduce whether or not there's a data phase
out based on the command byte?  urgh.

There's a somehat better-maintained driver -- fdomain.c.  It'd be great
if someone could make fdomain.c support the MCA cards -- and even the PCMCIA
cards without having the separate fdomain_stub.c.  I'd be happy to make
suggestions to anyone who has an fdomain card and wants to take on the
responsibility of maintaining the driver.

If anyone's really keen, there's an ISA card on eBay for $2 ...
http://cgi.ebay.com/ws/eBayISAPI.dll?ViewItem&item=5152656129

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
