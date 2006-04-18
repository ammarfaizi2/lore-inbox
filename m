Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWDRUKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWDRUKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWDRUKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:10:24 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:61692 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932309AbWDRUKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:10:22 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Crispin Cowan <crispin@novell.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <44453E7B.1090009@novell.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>
	 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>
	 <44453E7B.1090009@novell.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 18 Apr 2006 16:14:12 -0400
Message-Id: <1145391252.16632.231.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 12:31 -0700, Crispin Cowan wrote:
> Karl MacMillan wrote:
> > Which is one reason why SELinux has types (equivalence classes) - it
> > makes it possible to group large numbers of applications or resources
> > into the same security category. The targeted policy that ships with
> > RHEL / Fedora shows how this works in practice.
> >   
> AppArmor (then called "SubDomain") showed how this worked in practice
> years before the Targeted Policy came along. The Targeted Policy
> implements an approximation to the AppArmor security model, but does it
> with domains and types instead of path names, imposing a substantial
> cost in ease-of-use on the user.

Just to clarify a few points:
- It is true that both AppArmor and SELinux with targeted policy only
(effectively) restrict a subset of processes, but SELinux with targeted
policy provides complete mediation of all objects and operations for
those processes, not just capabilities and files like AppArmor.
   
- Targeted policy demonstrates that a general purpose mechanism that is
capable of complete mediation of all processes, objects, and operations
(SELinux) can be applied to selective control if that is your goal.  The
reverse is not true; AppArmor is limited by its design.

- Ease of use should be addressed in the user interface, not by using a
broken kernel mechanism.   There is ongoing work to address the
useability of SELinux in userspace; it doesn't require changing the
kernel mechanism to rely on pathnames (which is broken).

-- 
Stephen Smalley
National Security Agency

