Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbTGCRh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 13:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbTGCRh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 13:37:28 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:8859
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S265087AbTGCRh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 13:37:27 -0400
Date: Thu, 3 Jul 2003 13:51:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add SELinux module to 2.5.74-bk1
Message-ID: <20030703175153.GC27556@gtf.org>
References: <1057254295.1110.1016.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057254295.1110.1016.camel@moss-huskers.epoch.ncsc.mil>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 01:44:55PM -0400, Stephen Smalley wrote:
> The patch against 2.5.74-bk1 available from
> http://www.nsa.gov/selinux/lk/2.5.74-bk1-selinux.patch.gz adds the
> SELinux module to the tree and modifies the security/Makefile and
> security/KConfig files for SELinux.  The last dependency for SELinux,
> the vm_enough_memory security hook, was included in -bk1.  Please
> consider applying.  Thanks.  diffstat output is below.  

nitpicks:

1) "selinux" is a poor toplevel directory.  We already have the toplevel
"security" directory, this code should go in there.

2) stick includes in the standard include/ directory.  I would suggest
include/security (if the headers are general) or
include/security/selinux.

3) I wonder if the kernel should have a generic hash table ADT?

	Jeff


