Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263621AbUD0BAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263621AbUD0BAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 21:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUD0BAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 21:00:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:14061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263621AbUD0BA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 21:00:29 -0400
Date: Mon, 26 Apr 2004 18:00:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Grzegorz Kulewski <kangur@polcom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       raven@themaw.net
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?)
In-Reply-To: <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org>
References: <20040426013944.49a105a8.akpm@osdl.org>
 <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net>
 <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net>
 <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org>
 <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net>
 <Pine.LNX.4.58.0404261510230.19703@ppc970.osdl.org>
 <Pine.LNX.4.58.0404270034110.4469@alpha.polcom.net>
 <20040426225620.GP17014@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net>
 <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
> 
> whee... 6 claims of hda - all by the same owner.

Would it make sense to add a "dump_stack()" and to print out the name of 
the binary that causes this too? Ie add something like

	printk("dumping stack for %s:\n", current->comm);
	dump_stack();

to the bd_claim() debugging thing...

It will fill the logs, but I don't think it happens often enough to be a 
bother...

		Linus
