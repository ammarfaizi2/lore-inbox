Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTDWTGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTDWTGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:06:12 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:61134 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264330AbTDWTGI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:06:08 -0400
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <20030423194501.B5295@infradead.org>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423191749.A4244@infradead.org>
	 <20030423112548.B15094@figure1.int.wirex.com>
	 <20030423194501.B5295@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051125476.14761.146.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 15:17:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 14:45, Christoph Hellwig wrote:
> Randomly userland shouldn't deal with these xattrs.  Remember you are
> talking about the ondisk represenation of your labelling - nothing
> but the labelling tools should ever touch it.

Not true.  ls should be able to display the security label.  find should
be able to locate files that have specific security labels.  cp should
be able to preserve the security label on copies.  logrotate should be
able to preserve the security label when rotating logs.  crond should be
able to check the security label on a crontab spool file to verify
consistency with the user's credentials with which the cron job will
run.  login/sshd need to set the security label on the user's terminal
device.  You'll find plenty of examples of patched userland in SELinux,
but none of these patches are specific to a particular set of security
attributes.  They just handle them as strings.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

