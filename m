Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbTDWUIA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbTDWUIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:08:00 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:1805 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263551AbTDWUH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:07:58 -0400
Date: Wed, 23 Apr 2003 21:20:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030423212004.A7383@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org> <20030423112548.B15094@figure1.int.wirex.com> <20030423194501.B5295@infradead.org> <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil> <20030423202614.A5890@infradead.org> <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Apr 23, 2003 at 03:52:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 03:52:14PM -0400, Stephen Smalley wrote:
> For many of the patched utilities, there would be no encoding of any
> specific policy/module as long as you have a single attribute name,
> since they are just handling the labels as strings.

That assumes every label is a string.

> As a side note, please keep in mind that SELinux is itself a generic
> framework for MAC policies, provides encapsulation of security labels,
> and allows security models and attributes to be added or removed without
> requiring changes outside of the security policy engine, which itself is
> an encapsulated component of the SELinux module.

That doesn't matter at all for this question - if you have a selinux_label
attribute you can add your different policies with string labels to
it.  But don't mix it up with others. 

> Not exactly.  Our patch to crond uses a generic policy API that was
> designed to support many different security models, so it doesn't have
> to be specific to SELinux.

So it doesn't hardcode your xattr?  That's what I suggested..

