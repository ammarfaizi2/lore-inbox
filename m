Return-Path: <linux-kernel-owner+w=401wt.eu-S1947429AbWLHWI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947429AbWLHWI7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 17:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947430AbWLHWI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 17:08:59 -0500
Received: from web36608.mail.mud.yahoo.com ([209.191.85.25]:40238 "HELO
	web36608.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1947425AbWLHWI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 17:08:58 -0500
Message-ID: <20061208220857.35002.qmail@web36608.mail.mud.yahoo.com>
X-YMail-OSG: S.pRdyIVM1k1Ms_SVRAwNQr7jB3ekumhL9D.vORvKwH.i97CmrGPJYGN06j1wrPHZAI.UE1VAavGKQ3FRmK7VBLXl0F9eIMgXbw_c0pz0s4Di.W5.ORW9cktSKhJL07m7ZNrUeQLjjU-
X-RocketYMMF: rancidfat
Date: Fri, 8 Dec 2006 14:08:57 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 0/2] file capabilities: two bugfixes
To: "Serge E. Hallyn" <serue@us.ibm.com>,
       Casey Schaufler <casey@schaufler-ca.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061208211626.GA30754@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Quoting Casey Schaufler (casey@schaufler-ca.com):
> > 
> > --- "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > 
> > > ...
> > > The other is that root can lose capabilities by
> > > executing files with
> > > only some capabilities set.  The next two
> patches
> > > change these
> > > behaviors.
> > 
> > It was the intention of the POSIX group that
> > capabilities be independent of uid. I would
> > argue that the old bevavior was correct, that
> > a program marked to lose a capability ought
> > to even if the uid is 0.
> 
> Agreed, and if SECURE_NOROOT is set, that is what
> happens.
> But by default SECURE_NOROOT is not set, in which
> case linux's
> implementation of capabilities behaves differently
> for root.
> 
> Without this latest patch, with SECURE_NOROOT not
> set, what was
> actually happening was that the kernel behaved as
> though
> SECURE_NOROOT was not set so long as there was no
> security.capability xattr, and always behaved as
> though
> SECURE_NOROOT was set if there was an xattr.  That's
> inconsistent
> and confusing behavior.
> 
> The worst part is that root can get around running
> the code
> with limited caps by just copying the file and
> running the
> copy.  So it adds no security benefit, and adds an
> inconsistency/complication which could cause
> security risks.

OK, no worries then.


Casey Schaufler
casey@schaufler-ca.com
