Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264209AbTDWSFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTDWSFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:05:47 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:61451 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264209AbTDWSFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:05:46 -0400
Date: Wed, 23 Apr 2003 19:17:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030423191749.A4244@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Apr 23, 2003 at 01:52:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 01:52:03PM -0400, Stephen Smalley wrote:
> This patch against 2.5.68 implements changes to the LSM xattr-related
> hooks and adds xattr handlers for ext[23] to support the use of extended
> attributes by security modules for storing file security labels, as
> described in my April 8th RFC posting.  Please apply, or let me know if
> any changes are needed.  Thanks.

First, please put the changes in the LSM API in a different patch from
the xattr changes, they're a different issue.

The other question is why do you name them system.security?  The name
sounds a bit too generic to me.  ACLs are certainly a security feature
and have different ATTRS, similar for the Posix capability and MAC
support in XFS.  As selinux is the flask implementation for Linux
what about system.flask_label?  (or system.selinux_label?)

