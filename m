Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbTDWSc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTDWSc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:32:56 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:13324 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264196AbTDWScz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:32:55 -0400
Date: Wed, 23 Apr 2003 19:45:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030423194501.B5295@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org> <20030423112548.B15094@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030423112548.B15094@figure1.int.wirex.com>; from chris@wirex.com on Wed, Apr 23, 2003 at 11:25:49AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 11:25:49AM -0700, Chris Wright wrote:
> It's really a namespace issue for user apps trying to deal with xattrs.

Yes.

> Being able to display the xattrs associated with a file in sane way,
> like getxattr(path, "system.security", ...).  Otherwise something like
> listxattr() then gettxttr(... "system.security.[blah]" ...).  Total
> freeform naming is a headache for userspace to deal with.  Esp. since we
> don't want to teach all userland tools about each individual module/policy.

Randomly userland shouldn't deal with these xattrs.  Remember you are
talking about the ondisk represenation of your labelling - nothing
but the labelling tools should ever touch it.

> There were a couple proposals to use common root like "system.security."
> (or the trusted namespace which was discussed in earlier threads).
> 
> Would you still prefer module specific naming?

Personally I give a damn about the actual naming.  Just make sure
that each name has a unique meaning associated with it.

