Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVBPPwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVBPPwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVBPPwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:52:54 -0500
Received: from web50201.mail.yahoo.com ([206.190.38.42]:26755 "HELO
	web50201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262048AbVBPPwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:52:51 -0500
Message-ID: <20050216155251.16202.qmail@web50201.mail.yahoo.com>
Date: Wed, 16 Feb 2005 07:52:51 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Thoughts on the "No Linux Security Modules framework" old claims 
To: Valdis.Kletnieks@vt.edu,
       Lorenzo =?ISO-8859-1?Q?=20=22Hern=E1ndez=22?=
	 =?ISO-8859-1?Q?=20=22Garc=EDa-Hierro=22?= <lorenzo@gnu.org>
Cc: rsbac@rsbac.org,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200502160421.j1G4Ls7l004329@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Valdis.Kletnieks@vt.edu wrote:


> Many auditing policies require an audit event to be
> generated if the operation
> is rejected by *either* the DAC (as implemented by
> the file permissions
> and possibly ACLs) *or* the MAC (as implemented by
> the LSM exit).  However,
> in most (all?) cases, the DAC check is made *first*,
> and the LSM exit isn't
> even called if the DAC check fails.  As a result, if
> you try to open() a file
> and get -EPERM due to the file permissions, the LSM
> exit isn't called and
> you can't cut an audit record there.

The advice given by the NSA during our B1
evaluation was that is was that in the case
above was that the MAC check should be done
first (because it's more important) and
because you want the audit record to report
the MAC failure whenever possible. The
team advised us that if we didn't do the MAC
check first we would have a tough row to hoe
explaining the design decision and an even
tougher time explaining that the audit of
MAC criteria had been met.


=====
Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
