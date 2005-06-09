Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVFIS0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVFIS0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 14:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFIS0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 14:26:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12698 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262440AbVFIS0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 14:26:33 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17064.35262.790619.560855@segfault.boston.redhat.com>
Date: Thu, 9 Jun 2005 14:26:06 -0400
To: raven@themaw.net
Cc: Andrew Morton <akpm@osdl.org>,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Michael Blandford <michael@kmaclub.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] autofs4 - bad lookup fix
In-Reply-To: <Pine.LNX.4.62.0506041543090.8502@donald.themaw.net>
References: <Pine.LNX.4.62.0506041543090.8502@donald.themaw.net>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding [PATCH] autofs4 - bad lookup fix; raven@themaw.net adds:

raven> For browsable autofs maps, a mount request that arrives at the same
raven> time an expire is happening can fail to perform the needed mount.

raven> This happens becuase the directory exists and so the revalidate
raven> succeeds when we need it to fail so that lookup is called on the
raven> same dentry to do the mount. Instead lookup is called on the next
raven> path component which should be whithin the mount, but the parent
raven> isn't mounted.

raven> The solution is to allow the revalidate to continue and perform the
raven> mount as no directory creation (at mount time) is needed for
raven> browsable mount entries.

I have a reproducer case for this, and the patch provided fixes it in my
environment.

-Jeff
