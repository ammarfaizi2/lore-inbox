Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264993AbUFCPzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbUFCPzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbUFCPyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:54:24 -0400
Received: from MS06.mse1.mailstreet.com ([63.251.155.142]:53335 "EHLO
	ms06.mse1.mailstreet.com") by vger.kernel.org with ESMTP
	id S264993AbUFCPxu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:53:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH/RFC] Lustre VFS patch, version 2
Date: Thu, 3 Jun 2004 11:53:43 -0400
Message-ID: <9025E129D3FCD340A7BA67E342D10E7AF11B72@proxy.mse1.mailstreet.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH/RFC] Lustre VFS patch, version 2
Thread-Index: AcRJeicxHxdNGL9jQw2rtESOjI1BtQAALIFQ
From: "Peter J. Braam" <braam@clusterfs.com>
To: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>, <akpm@osdl.org>
Cc: "Christoph Hellwig" <hch@infradead.org>, <axboe@suse.de>,
       <kevcorry@us.ibm.com>, <arjanv@redhat.com>,
       <viro@parcelfarce.linux.theplanet.co.uk>, <anton@samba.org>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       "Lars Marowsky-Bree" <lmb@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Of course I am totally happy to include or not include the Lustre client
with it.  However, that does lead to a sizeable amount of (completely
modular) code, as it depends on the networking, lock manager, logical
volume driver and metadata and object storage clients and the management
framework.  It's 2M.

I'd like to also acknowledge that we should remove the small
incompatibility in the names of intents, to preserve api compatibility,
and add an inode method for intent execution.  Yes, the LUSTRE_INVALID
flag was discussed on irc with Al Viro: he said that probably I really
needed _something_, he said it's hairy, so it was coded to not affect
anyone that doesn't use that flag.

I have not worked on Coda for 5 years, and have nothing to say about it.
I have recently withdrawn InterMezzo to be helpful to the kernel
community.  Of course I would offer the same for Lustre.  But as I have
said before, this time there are a lot of resources to maintain this.

Perhaps it is useful to explain that vendors (Novell, Dell, HP and
others) have urged me to enquire if the hooks could go into 2.6.  All of
them have really major Lustre customers, running top10 super computing
clusters with Lustre.  Having the hooks avoids having to patch vendor
kernels, which breaks support arrangements.  As for our position, it's
in fact easier to wait and just collect clever insights from time to
time. 

I represent them here.  I understand and would respect the wait until
2.7 argument, but I think it is workable to get them into 2.6.  Is it
really a big deal to go through these small patches a few more times to
judge if they are safe, and to include them?  I think it would help
people who care and support Linux financically.  I only hear Christoph
arguing against it, are there other insights?

Again many thanks for spending time to study the patches, it has already
helped Lustre get better.

- Peter -

