Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbTDWSYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264187AbTDWSYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:24:33 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:49612 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264182AbTDWSYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:24:32 -0400
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <20030423191749.A4244@infradead.org>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423191749.A4244@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051122958.14761.110.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 14:35:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 14:17, Christoph Hellwig wrote:
> First, please put the changes in the LSM API in a different patch from
> the xattr changes, they're a different issue.

I don't mind splitting them into a separate patch (and offered to do so
in the earlier posting against 2.5.67), but I don't agree that they are
a different issue.  The changes to the LSM xattr-related hooks are part
of supporting the use of extended attributes by security modules for
file security labels; the changes permit the security module to update
the inode security structure upon successful setxattr calls, and to
provide atomicity for the check and update of the security label.

> The other question is why do you name them system.security?  The name
> sounds a bit too generic to me.  ACLs are certainly a security feature
> and have different ATTRS, similar for the Posix capability and MAC
> support in XFS.  As selinux is the flask implementation for Linux
> what about system.flask_label?  (or system.selinux_label?)

The idea of using separate attribute names for each security module was
already discussed at length when I posted the original RFC, and I've
already made the case that this is not desirable.  Please see the
earlier discussion.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

