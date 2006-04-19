Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWDSMuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWDSMuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWDSMuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:50:24 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:33680 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750716AbWDSMuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:50:23 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 19 Apr 2006 08:54:24 -0400
Message-Id: <1145451264.24289.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 18:48 -0700, Casey Schaufler wrote:
> 
> --- James Morris <jmorris@namei.org> wrote:
> 
> 
> > With pathnames, there is an unbounded and unknown
> > number of effective 
> > security policies on the system, as there are an
> > unbounded and unknown 
> > number of ways of viewing the files via pathnames.
> 
> I agree that for traditional DAC and MAC (including
> the flavors supported by SELinux) inodes is the
> only way to go. SELinux is a traditional Trusted OS
> architecture and addresses the traditional Trusted
> OS issues. 

Hmmm..can't say that SELinux has been accused of being a "traditional
trusted OS architecture" before.  Flask and TE aren't precisely
traditional.  But it does preserve the key characteristics required to
support real MAC.

> But as someone demonstrated earlier, not everyone
> believes that an EAL makes them feel secure and that
> is what LSM is really all about, allowing people
> who don't care about Protection Profiles but who do
> care about security to do something about it. How
> many of you have lambasted me over the years because
> I bled Orange? If SELinux is the only "secure" Linux
> haven't the Orange Book/Common Criteria people proven
> right in the end?

This would be fine, if the technical approach were sound (not
necessarily the same as SELinux, but sound) and fit properly with the
LSM interface.  But the path-based approach isn't technically sound, and
even if we were to assume that it was, it isn't even a good fit for the
LSM hook interfaces.
 
-- 
Stephen Smalley
National Security Agency

