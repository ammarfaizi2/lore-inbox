Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWDTMXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWDTMXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 08:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWDTMXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 08:23:54 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:45462 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750820AbWDTMXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 08:23:53 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Emily Ratliff <ejratl@gmail.com>
Cc: David Safford <safford@watson.ibm.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, James Morris <jmorris@namei.org>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1145471636.24289.236.camel@moss-spartans.epoch.ncsc.mil>
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com>
	 <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417192634.GB18990@sergelap.austin.ibm.com>
	 <Pine.LNX.4.64.0604171528340.17923@d.namei>
	 <20060417194759.GD18990@sergelap.austin.ibm.com>
	 <1145304146.8542.251.camel@moss-spartans.epoch.ncsc.mil>
	 <1145458322.2377.12.camel@localhost.localdomain>
	 <1145460417.24289.116.camel@moss-spartans.epoch.ncsc.mil>
	 <2e00cdfd0604191057h5d663319xab6ee62ca58fbe28@mail.gmail.com>
	 <1145471636.24289.236.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 20 Apr 2006 08:27:54 -0400
Message-Id: <1145536074.16456.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 14:33 -0400, Stephen Smalley wrote:
> On Wed, 2006-04-19 at 12:57 -0500, Emily Ratliff wrote:
> > Dave has an existing implementation with a user base of a formally
> > proven security model. He is addressing implementation concerns and
> > continuing to try to get SLIM accepted. Why should he be required to
> > extend SELinux?
> 
> Well, I haven't seen any new code submitted since last Nov, and the code
> at that time was badly broken to the point that it seemed to require a
> re-design, and none of the modules at the time appeared to justify LSM
> or the stacker; if anything, they were a warning that the stacker and
> LSM lend themselves to misuse, confusion, and broken code.
> 
> I'm sure we'd all be glad to see new patches.  But the issues that were
> raised during the original discussion still need to be addressed.

BTW, this isn't the first time that he has been encouraged to consider
extending SELinux rather than going it alone with his own custom LSM,
and the benefits to him would be:
- leveraging an existing code base and infrastructure that is already
upstream and included in several distros (including both the kernel code
as well as integration with userspace, policy tools, policy management
infrastructure, etc),
- being able to leverage the existing TE security model to complement
and fill in the gaps left by the low water mark model, just as it is
already being used to complement MLS,
- ensuring that the result integrates well and works well with SELinux,
for those who may want both low water mark and TE.

-- 
Stephen Smalley
National Security Agency

