Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWHPCZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWHPCZy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWHPCZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:25:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47567 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750830AbWHPCZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:25:53 -0400
Date: Tue, 15 Aug 2006 21:25:50 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060816022550.GC15241@sergelap.austin.ibm.com>
References: <20060814220651.GA7726@sergelap.austin.ibm.com> <20060815160246.81566.qmail@web36601.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815160246.81566.qmail@web36601.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Casey Schaufler (casey@schaufler-ca.com):
> 
> 
> --- "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> 
> > +
> > +	bprm->cap_effective = fscaps[0];
> > +	bprm->cap_inheritable = fscaps[1];
> > +	bprm->cap_permitted = fscaps[2];
> > +
> 
> It does not appear that you're attempting
> to maintain the POSIX exec semantics for
> capability sets. (If you're doing it
> elsewhere in the code, nevermind) I don't
> know if this is intentional or not.

It should be getting done correctly at bprm_apply_creds.
The code you quote here is just setting it on the
binprm, which represents the executable itself (and as
pointed out in the comment above it).

Now the cap_bprm_secureexec() function needs to be
updated as I believe I pointed out in the original
submission.  But if anything else is not getting done
right please correct me.

> I will have a closer look, but just for
> grins, I've attached code from the SGI
> OB1 offering of some years back that
> includes a function, cap_recalc, that
> implements the correct behavior. I will
> also take a stab at working it in, but

Excellent, thanks.

> I expect someone will beat me to it.

-serge
