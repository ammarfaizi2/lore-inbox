Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUG2Nas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUG2Nas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 09:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUG2Nas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 09:30:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39307 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264638AbUG2Nar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 09:30:47 -0400
Date: Thu, 29 Jul 2004 14:30:43 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Please revert fdomain_cs patch
Message-ID: <20040729133043.GJ10025@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://linux.bkbits.net:8080/linux-2.5/cset@410892ddUn7UwCK2j1NDA0BpgNaFHQ?nav=index.html|ChangeSet@-2d
is bogus, please revert it.  fdomain_cs drives a PCMCIA card.  Obviously
you can plug a PCMCIA card into a PowerPC.  So the correct fix for this
is either to have ppc provide isa_readb() et al, or for the driver to
be converted to use ioremap().

We should probably hang __deprecated tags on the isa_* functions.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
