Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUIIRpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUIIRpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUIIRol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:44:41 -0400
Received: from open.hands.com ([195.224.53.39]:55257 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S266425AbUIIRdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:33:19 -0400
Date: Thu, 9 Sep 2004 18:44:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040909174431.GE10046@lkcl.net>
References: <20040909162200.GB9456@lkcl.net> <1094747347.22014.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094747347.22014.94.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 12:29:07PM -0400, Stephen Smalley wrote:
> On Thu, 2004-09-09 at 12:22, Luke Kenneth Casson Leighton wrote:
> > 	i do not believe it to be sensible to have the kernel
> > 	code doing that kind of checking (resolving the full
> > 	pathname of an executable) but hey, if anyone feels
> > 	otherwise, and knows of some pre-existing code to point
> > 	me in the direction of, i'll add it, because it might
> > 	be easier in the long run.
> <snip>
> > 	has someone already done this before now, and if so,
> > 	where?
> 
> d_path() will give you a pathname given a (dentry, vfsmount) pair.
 
 GREAT.
 
 thank you, that means i _can_ put full path names into an
 iptables rule, which will make life a lot easier from a userspace
 perspective.  i'm a bit worried about keeping the rules list
 up-to-date if an inode changes.

 fireflier already constructs the full path name of the executable
 in its userspace code, for comparison against its rules.

 _i_ accept the performance penalty (per per-packet) but some
 people won't.... and such people will just have to live with
 per-packet firewall rules (not per-packet per-program).

 [or, and i mention this for the benefit of lkml people,
  to create per-program SE/Linux network policy rules, as
  already described by stephen on sel-ml last week]

 l.
