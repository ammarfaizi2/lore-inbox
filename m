Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUHDO4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUHDO4Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 10:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbUHDO4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 10:56:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56755 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266193AbUHDO4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 10:56:19 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16656.63625.650665.626364@segfault.boston.redhat.com>
Date: Wed, 4 Aug 2004 10:54:01 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix netpoll cleanup on abort without dev
In-Reply-To: <20040804142049.GL16310@waste.org>
References: <20040804142049.GL16310@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding [PATCH] Fix netpoll cleanup on abort without dev; Matt Mackall <mpm@selenic.com> adds:

mpm> If netpoll attempts to use a device without polling support, it will
mpm> oops when shutting down. This adds a check that we've actually
mpm> attached to a device.

Hi, Matt,

Perhaps I'm missing something, but how do we successfully return from
netpoll_setup without np->dev filled in?  Netpoll_setup has the following:

        if (!ndev->poll_controller) {
                printk(KERN_ERR "%s: %s doesn't support polling, aborting.\n",
                       np->name, np->dev_name);
                goto release;
        }


Thanks,

Jeff
