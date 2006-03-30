Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWC3CDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWC3CDx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWC3CDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:03:53 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36226 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751437AbWC3CDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:03:52 -0500
Date: Wed, 29 Mar 2006 18:04:46 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: David Lang <dlang@digitalinsight.com>
Cc: Chris Wright <chrisw@sous-sol.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060330020445.GT15997@sorel.sous-sol.org>
References: <20060328142639.GE14576@MAIL.13thfloor.at> <44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com> <20060330013618.GS15997@sorel.sous-sol.org> <Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Lang (dlang@digitalinsight.com) wrote:
> what if the people administering the container are different from the 
> people administering the host?

Yes, I alluded to that.

> in that case the people working in the container want to be able to 
> implement and change their own policy, and the people working on the host 
> don't want to have to implement changes to their main policy config (wtih 
> all the auditing that would be involved with it) every time a container 
> wants to change it's internal policy.

*nod*

> I can definantly see where a container aware policy on the master would be 
> useful, but I can also see where the ability to nest seperate policies 
> would be useful.

This is all fine.  The question is whether this is a policy management
issue or a kernel infrastructure issue.  So far, it's not clear that this
really necessitates kernel infrastructure changes to support container
aware policies to be loaded by physical host admin/owner or the virtual
host admin.  The place where it breaks down is if each virtual host
wants not only to control its own policy, but also its security model.
Then we are left with stacking modules or heavier isolation (as in Xen).

thanks,
-chris
