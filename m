Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVHOO6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVHOO6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 10:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVHOO6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 10:58:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:51898 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964784AbVHOO6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 10:58:47 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17152.44448.916315.2363@tut.ibm.com>
Date: Mon, 15 Aug 2005 09:58:40 -0500
To: Hareesh Nagarajan <hareesh@google.com>
Cc: Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel@vger.kernel.org, karim@opersys.com
Subject: Re: [PATCH] [TRIVIAL] relayfs: remove comment on overwrite mode
In-Reply-To: <43001B44.3050205@google.com>
References: <43001B44.3050205@google.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hareesh Nagarajan writes:
 > Hi Andrew,
 > 
 > The overwrite arg has been removed from the relay_subbufs_consumed() 
 > (since it has been removed from relayfs altogether) so the comment 
 > preceding the function must go.

relayfs still supports overwrite mode, but it's now implemented
differently (via the subbuf_start() callback instead of an overwrite
arg), so this comment is still valid.

Tom

 > 
 > Thanks,
 > 
 > Hareesh
 > diff -ruN linux-akpm/fs/relayfs/relay.c linux/fs/relayfs/relay.c
 > --- linux-akpm/fs/relayfs/relay.c	2005-08-14 21:16:35.000000000 -0700
 > +++ linux/fs/relayfs/relay.c	2005-08-14 21:26:10.000000000 -0700
 > @@ -342,9 +342,6 @@
 >   *	Adds to the channel buffer's consumed sub-buffer count.
 >   *	subbufs_consumed should be the number of sub-buffers newly consumed,
 >   *	not the total consumed.
 > - *
 > - *	NOTE: kernel clients don't need to call this function if the channel
 > - *	mode is 'overwrite'.
 >   */
 >  void relay_subbufs_consumed(struct rchan *chan,
 >  			    unsigned int cpu,



