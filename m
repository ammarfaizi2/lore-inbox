Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTDXMvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 08:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTDXMvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 08:51:53 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:4627 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261773AbTDXMvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 08:51:52 -0400
Date: Thu, 24 Apr 2003 14:03:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030424140358.A30888@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org> <20030423112548.B15094@figure1.int.wirex.com> <20030423194501.B5295@infradead.org> <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil> <20030423202614.A5890@infradead.org> <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil> <20030423212004.A7383@infradead.org> <1051188945.14761.284.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051188945.14761.284.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Thu, Apr 24, 2003 at 08:55:46AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 08:55:46AM -0400, Stephen Smalley wrote:
> attributes.  Andreas Gruenbacher had suggested during the earlier thread
> that we use something like the xattr_trusted.c attribute handler, so
> that a single xattr handler would cover all security modules but each
> security module could have its own attribute name (security.selinux,
> security.dte, security.capabilities, etc).  As I explained during that
> thread, I don't think we want to use the trusted attribute handler
> itself due to its permission checking model,

Hmm, what would you think of changing the xattr_trusted security
model to fit your needs?  It's so far unused outside XFS and there's
maybe a chance changing it.

> but it would be easy to
> make the xattr_security.c handler more like xattr_trusted.c in terms of
> allowing arbitrary extensions of a "security." prefix.  Is that more to
> your liking, or do you truly want a separate handler for each security
> module?

It's fine with me.

