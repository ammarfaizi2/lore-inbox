Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUKVXpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUKVXpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbUKVXop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:44:45 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:28680 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262422AbUKVXg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:36:28 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com>
	<20041122713.g6bh6aqdXIN4RJYR@topspin.com>
	<20041122222507.GB15634@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 22 Nov 2004 15:34:23 -0800
In-Reply-To: <20041122222507.GB15634@kroah.com> (Greg KH's message of "Mon,
 22 Nov 2004 14:25:07 -0800")
Message-ID: <527jodbgqo.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA (Subnet Administration)
 query support
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 23:34:29.0085 (UTC) FILETIME=[CF8728D0:01C4D0EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Please hack your submit script to not add these headers,
    Greg> when importing to bk they end up showing up in the change
    Greg> log comments :(

OK, will do.

    Greg> No email address of who to bug with issues?

There's a patch to MAINTAINERS...

    Greg> Why is this packed?
    Greg> Same here?

Both of these structures unfortunately have 64 bit fields only aligned
to 32 bits (and are sent on the wire so we can't fiddle with the
layout).  So without the "packed" they won't come out right on 64-bit archs.

    Greg> Should this be global or static?

static, fixed.

    Greg> Oops, tabs vs. spaces.

fixed.

    Greg> Care to use the __bitwise field here so that you can have
    Greg> sparse check to see that you are actually using the proper
    Greg> enum values in all places?  See the kobject_action code for
    Greg> an example of this.

Sure, that's a good idea.  I'll look for other places we can do this too.

    Greg> What is "RESERVED"?  I must be missing a previous patch
    Greg> somewhere, I currently don't see all of the series yet.

It's in part 1/12: http://article.gmane.org/gmane.linux.kernel/257531
unfortunately some people marked it as spam and it didn't get
everywhere.

 - Roland
