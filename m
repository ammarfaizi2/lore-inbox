Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWDQWop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWDQWop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWDQWop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:44:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14287 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751366AbWDQWoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:44:44 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <E1FVc0H-00077d-00@w-gerrit.beaverton.ibm.com>
References: <E1FVc0H-00077d-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Apr 2006 23:48:04 +0100
Message-Id: <1145314085.14793.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-17 at 15:15 -0700, Gerrit Huizenga wrote:
> I get the impression from customers that SELinux is so painful to
> configure correctly that most of them disable it.  In theory, LSM +

Red Hat ships SELinux enabled by default with a set of policies that
most users just leave enabled, indeed most users don't even know they
have SELinux enabled or what SELinux is, any more than they could say
tell you what posix acls do.

That said there is a need for nice pretty policy design tools, but
that's not part of an LSM discussion.

> something like AppArmour provides a much simpler security model for

If the AppArmour people care to submit their code upstream and get it
merged then that would be a reason to keep LSM, if they don't then LSM
(if they even want it..) can just become part of their patchkit instead.

> normal human beings who want some level of configuration.  Also,
> the current SELinux config in RH is starting to have a measureable
> performance impact. 

In Fedora Core its impact is far from obvious from my testing. Older
SELinux had some ugly SMP scaling problems but those are fixed.

Alan

