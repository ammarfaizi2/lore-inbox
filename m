Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVFPAIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVFPAIA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 20:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVFPAIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 20:08:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27299 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261394AbVFPAHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 20:07:53 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17072.49843.360761.694530@segfault.boston.redhat.com>
Date: Wed, 15 Jun 2005 20:07:15 -0400
To: raven@themaw.net
Cc: Andrew Morton <akpm@osdl.org>, Michael Blandford <michael@kmaclub.com>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] autofs4 - post expire race fix
In-Reply-To: <Pine.LNX.4.62.0506041528070.8502@donald.themaw.net>
References: <Pine.LNX.4.62.0506041528070.8502@donald.themaw.net>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding [PATCH] autofs4 - post expire race fix; raven@themaw.net adds:

raven> At the tail end of an expire it's possible for a process to enter
raven> autofs4_wait, with a waitq type of NFY_NONE but find that the expire
raven> is finished. In this cause autofs4_wait will try to create a new
raven> wait but not notify the daemon leading to a hang. As the wait type
raven> is meant to delay mount requests from revalidate or lookup during an
raven> expire and the expire is done all we need to do is check if the
raven> dentry is a mountpoint. If it's not then we're done.

FWIW, this looks good to me.  (sorry for the late reply)

Thanks,

Jeff
