Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTDXUkC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbTDXUkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:40:02 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:33269 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S264375AbTDXUj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:39:57 -0400
Date: Thu, 24 Apr 2003 13:47:02 -0700
From: Chris Wright <chris@wirex.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lsm <linux-security-module@wirex.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030424134702.H15094@figure1.int.wirex.com>
Mail-Followup-To: Stephen Smalley <sds@epoch.ncsc.mil>,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Stephen Tweedie <sct@redhat.com>,
	lsm <linux-security-module@wirex.com>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil> <20030423202614.A5890@infradead.org> <1051127534.14761.166.camel@moss-huskers.epoch.ncsc.mil> <20030423212004.A7383@infradead.org> <1051188945.14761.284.camel@moss-huskers.epoch.ncsc.mil> <20030424140358.A30888@infradead.org> <1051192166.14761.334.camel@moss-huskers.epoch.ncsc.mil> <20030424113615.F15094@figure1.int.wirex.com> <1051210971.20300.89.camel@moss-huskers.epoch.ncsc.mil> <20030424134040.T26054@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030424134040.T26054@schatzie.adilger.int>; from adilger@clusterfs.com on Thu, Apr 24, 2003 at 01:40:40PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Dilger (adilger@clusterfs.com) wrote:
> 
> Couldn't that be used to do the trusted-namespace- means-CAP_SYS_ADMIN
> checks, but it can be replaced by other LSM security modules if desired?

I think that's what Stephen is saying.  The issue is, the "trusted."
handler uses CAP_SYS_ADMIN internally, after any other LSM check has
already occurred.  And the capable() check is too simple to know things
like which inode's xattr is in question at the moment or which namespace.
So Stephen was suggesting moving it out of the handler and putting it
in core code.

cheers,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
