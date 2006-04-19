Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWDSOwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWDSOwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWDSOwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:52:21 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:57565 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750815AbWDSOwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:52:20 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: David Safford <safford@watson.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, James Morris <jmorris@namei.org>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1145304146.8542.251.camel@moss-spartans.epoch.ncsc.mil>
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com>
	 <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417192634.GB18990@sergelap.austin.ibm.com>
	 <Pine.LNX.4.64.0604171528340.17923@d.namei>
	 <20060417194759.GD18990@sergelap.austin.ibm.com>
	 <1145304146.8542.251.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 10:52:02 -0400
Message-Id: <1145458322.2377.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 16:02 -0400, Stephen Smalley wrote: 
> At the conclusion of the last round of discussions on slim-evm-ima on
> list, it was the case that:

> ima was no longer an issue, as it had already ceased being a separate
> LSM,

Agreed. Integrity attestation clearly needed to be tightly coupled with
integrity measurement.

> it was demonstrated that evm needed to be tightly coupled with any LSM
> in order to work correctly and efficiently, and it seemed to be accepted
> that evm needed to be turned from a separate LSM into a set of support
> functions for use by a LSM (as well as having many other design and
> implementation problems to resolve to be truly useable),

It was certainly agreed that integrity needed to be a separate service
available to any access control module, with nothing specific to SLIM, 
and that a number of design and implementation problems had to be fixed. 
During testing we also found a number of other bugs which weren't raised 
on the list, which had to be fixed. (That's what has taken us so long to 
post a new version.) As to whether it should be tightly coupled to an
LSM module, or should be a separate service with its own kernel hooks,
I think was not settled. 

> - it was argued that slim was broken-by-design and no one was willing or
> able to refute that position.
> 
> Hardly a strong case for LSM...

I seem to recall a number of people arguing for the low water-mark 
integrity policy as one which provides a simple, user friendly 
policy, one which has been demonstrated and tested not only by
SLIM, but also with predecessors, such as LOMAC. 

I do understand and respect the selinux position against dynamic 
labels, since they require revocation, and particularly since at 
that time, we had not implemented revocation of mmap access. We 
have been quietly studying, fixing, and testing the design and
implementation errors pointed out earlier, and still feel strongly 
that low water-mark policies have a place, particularly in client
systems. 

Since selinux (by choice) cannot implement policies with dynamic labels,
I believe LSM is important for work in alternative access control
models, like low water-mark, to continue.

dave safford




