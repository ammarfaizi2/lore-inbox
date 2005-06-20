Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVFTPBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVFTPBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFTPBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:01:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64454 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261273AbVFTPBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:01:30 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17078.55866.893715.792418@segfault.boston.redhat.com>
Date: Mon, 20 Jun 2005 11:01:14 -0400
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Matt Mackall <mpm@selenic.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: netpoll and the bonding driver
In-Reply-To: <20050620002118.GA16859@tuxdriver.com>
References: <17075.10995.498758.773092@segfault.boston.redhat.com>
	<20050619181436.GX27572@waste.org>
	<20050620002118.GA16859@tuxdriver.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netpoll and the bonding driver; "John W. Linville" <linville@tuxdriver.com> adds:

linville> On Sun, Jun 19, 2005 at 11:14:36AM -0700, Matt Mackall wrote:
>> On Fri, Jun 17, 2005 at 03:56:35PM -0400, Jeff Moyer wrote:

>> > I'm trying to implement a netpoll hook for the bonding driver.
>> 
>> My first question would be: does this really make sense to do? Why not
>> just bind netpoll to one of the underlying devices?

linville> Depending on the bonding mode, this would be very unlikely to
linville> work.  The other side of the link will still be expecting to talk
linville> to the bond rather than to an individual link.

Right, and for those drivers which register a netpoll_rx routine, they may
not get all of the packets destined for them.

-Jeff
