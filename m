Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWKBROu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWKBROu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWKBROu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:14:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:25475 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751552AbWKBROt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:14:49 -0500
Subject: Re: [PATCH] Fix user.* xattr permission check for sticky dirs
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Gerard Neil <xyzzy@devferret.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0611021759390.24554@yvahk01.tjqt.qr>
References: <200611021724.02886.agruen@suse.de>
	 <Pine.LNX.4.61.0611021759390.24554@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 11:14:15 -0600
Message-Id: <1162487655.18730.2.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 17:59 +0100, Jan Engelhardt wrote:
> >
> >The user.* extended attributes are only allowed on regular files and
> >directories. Sticky directories further restrict write access to the
> >owner and privileged users. (See the attr(5) man page for an
> >explanation.)
> >
> 
> Does this effect ACL handling for sticky dirs in any way?

No.  xattr_permission (which this patch hits) always returns 0 for
system.* attributes and leaves it to the file system to handle.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center


