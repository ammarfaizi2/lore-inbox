Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264166AbTDWSSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbTDWSSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:18:38 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:49134 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S264166AbTDWSSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:18:37 -0400
Date: Wed, 23 Apr 2003 11:25:49 -0700
From: Chris Wright <chris@wirex.com>
To: Christoph Hellwig <hch@infradead.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030423112548.B15094@figure1.int.wirex.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030423191749.A4244@infradead.org>; from hch@infradead.org on Wed, Apr 23, 2003 at 07:17:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig (hch@infradead.org) wrote:
> 
> The other question is why do you name them system.security?  The name
> sounds a bit too generic to me.  ACLs are certainly a security feature
> and have different ATTRS, similar for the Posix capability and MAC
> support in XFS.  As selinux is the flask implementation for Linux
> what about system.flask_label?  (or system.selinux_label?)

It's really a namespace issue for user apps trying to deal with xattrs.
Being able to display the xattrs associated with a file in sane way,
like getxattr(path, "system.security", ...).  Otherwise something like
listxattr() then gettxttr(... "system.security.[blah]" ...).  Total
freeform naming is a headache for userspace to deal with.  Esp. since we
don't want to teach all userland tools about each individual module/policy.

There were a couple proposals to use common root like "system.security."
(or the trusted namespace which was discussed in earlier threads).

Would you still prefer module specific naming?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
