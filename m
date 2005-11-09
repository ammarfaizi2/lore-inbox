Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbVKIWzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbVKIWzt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbVKIWzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:55:49 -0500
Received: from fmr24.intel.com ([143.183.121.16]:21970 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1161047AbVKIWzs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:55:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: merge status
Date: Wed, 9 Nov 2005 14:54:12 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04EADD18@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: merge status
Thread-Index: AcXlda3soqcFzv6LRvCRFApEV82DhQACMFAg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: "James Bottomley" <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Ben Collins" <bcollins@debian.org>,
       "Jody McIntyre" <scjody@modernduck.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Roland Dreier" <rolandd@cisco.com>,
       "Dave Jones" <davej@codemonkey.org.uk>, "Jens Axboe" <axboe@suse.de>,
       "Dave Kleikamp" <shaggy@austin.ibm.com>,
       "Steven French" <sfrench@us.ibm.com>
X-OriginalArrivalTime: 09 Nov 2005 22:54:13.0737 (UTC) FILETIME=[81464D90:01C5E580]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -rw-r--r--    1 akpm     akpm        78245 Nov  9 11:19 git-ia64.patch

Some of this size may be a git artifact (or to be strictly accurate
an artifact of the way I maintain my git branches).  I just merged
up the latest linus branch into my test tree, and then ran:

 $ git diff linus test

which only came up with 34799 bytes of diff.  The extra bytes you
see may be due to some commits that went into my test tree, but
I goofed some of the comments ... so I ended up with the same patches
going to my release tree, but as different commits.  I assume that
quilt then figures out that this stuff is already in Linus tree?

I think that I may need to periodically ditch and re-create my test
branch ... it is full of "Auto-update from upstream" commits, plus
all the commits to pull in topic branches.  So when I've merged
over all the topic branches to send to Linus the contents of the
tree exactly match my release tree ... the history is very different
(and somewhat messy in places).

-Tony
