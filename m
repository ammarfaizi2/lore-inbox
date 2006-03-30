Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWC3SB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWC3SB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWC3SB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:01:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53430 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751347AbWC3SB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:01:56 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, David Lang <dlang@digitalinsight.com>,
       Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com>
	<442A26E9.20608@vilain.net>
	<20060329182027.GB14724@sorel.sous-sol.org>
	<442B0BFE.9080709@vilain.net>
	<20060329225241.GO15997@sorel.sous-sol.org>
	<m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
	<20060330013618.GS15997@sorel.sous-sol.org>
	<Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz>
	<20060330020445.GT15997@sorel.sous-sol.org>
	<20060330143224.GC6933@sergelap.austin.ibm.com>
	<20060330153012.GA16720@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 30 Mar 2006 11:00:19 -0700
In-Reply-To: <20060330153012.GA16720@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Thu, 30 Mar 2006 17:30:12 +0200")
Message-ID: <m1fykzdd8s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> sorry folks, I don't think that we _ever_ want container
> root to be able to load any kernel modues at any time
> without having CAP_SYS_ADMIN or so, in which case the
> modules can be global as well ... otherwise we end up
> as a bad Xen imitation with a lot of security issues,
> where it should be a security enhancement ...

Agreed.  At least until someone defines a user-mode
linux-security-module.  We may want a different security module
in effect for a particular guest.  Which modules you get
being defined by the one system administrator is fine.

The primary case I see worth worry about is using 
a security module to ensure isolation of a container,
while still providing the selinux mandatory capabilities
to a container.

Eric
