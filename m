Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTDWTH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTDWTH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:07:56 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:53245 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S264368AbTDWTHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:07:52 -0400
Date: Wed, 23 Apr 2003 12:15:17 -0700
From: Chris Wright <chris@wirex.com>
To: Christoph Hellwig <hch@infradead.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030423121517.C15094@figure1.int.wirex.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org> <20030423112548.B15094@figure1.int.wirex.com> <20030423125452.I26054@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030423125452.I26054@schatzie.adilger.int>; from adilger@clusterfs.com on Wed, Apr 23, 2003 at 12:54:52PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Dilger (adilger@clusterfs.com) wrote:
> 
> Well, with the exception of backup/restore (which will just treat this
> EA data as opaque and doesn't really care whether the names are fixed
> or not), the tools DO need to understand each individual module
> or policy in order to make any sense of the data.  Otherwise, all you
> can do is print out some binary blob which is no use to anyone.

I was imagining strings, not binary blobs, sorry for the confusion.

> So, either the tools look for "system.security", and then have to
> understand an internal magic for each module to know what to do with
> the data, or it looks for "system.<modulename>" for only module names
> that it actually understands.

Or simply print the strings associated with the label.

> The only reason to use a common "system.security" is if the actual data
> stored therein was usable by more than a single security module.

Or, as mentioned, if you care to print out the label with standard
fileutils.

cheers,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
