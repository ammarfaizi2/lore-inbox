Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVBPQHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVBPQHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVBPQHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:07:30 -0500
Received: from web50201.mail.yahoo.com ([206.190.38.42]:3430 "HELO
	web50201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262061AbVBPQHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:07:11 -0500
Message-ID: <20050216160710.23689.qmail@web50201.mail.yahoo.com>
Date: Wed, 16 Feb 2005 08:07:10 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Thoughts on the "No Linux Security Modules framework" old claims
To: Lorenzo =?ISO-8859-1?Q?=20=22Hern=E1ndez=22?=
	 =?ISO-8859-1?Q?=20=22Garc=EDa-Hierro=22?= <lorenzo@gnu.org>,
       Valdis.Kletnieks@vt.edu
Cc: rsbac@rsbac.org,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1108560543.3826.89.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Lorenzo Hernández García-Hierro <lorenzo@gnu.org>
wrote:


> ... but think it's main
> shortcoming is that it cuts
> performance

Ya'know, I keep hearing this assertion, but
the evidence of actual system implementations
that have been measured to determine this
"performance impact" is that there is no
difference except in contrived cases. In
contrived cases the performance is better
if you do the "special" checks first.

> and adds further overlapping to the DAC
> checks, that should
> be the first ones being called (as most times they
> do) and then apply
> the LSM basis, so, post-processing will be only
> required if the DAC
> checks get in override or passed, without adding
> too-much overhead to
> the current behavior.

No. There are a number of reasons, including
audit and nearline storage issues that make it
important to do the special checks first. Some
access control schemes may not work if the
Classic DAC check is done first.

> So, I just agree partially, but yes, maybe modifying
> the DAC checks
> themselves and add what-ever-else helper function to
> handle by-default
> auditing in certain operations could be interesting.

I remain a advocate of authoritative hooks.

> I think it could be worthy to have a roadmap in a
> wiki or even talk
> about a one, trying to write it, so, we all could
> know what needs to be
> improved and done, getting a higher percentage of
> mainline-accepted
> approaches.

Sigh.


=====
Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
