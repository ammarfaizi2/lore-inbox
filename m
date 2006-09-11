Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWIKQWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWIKQWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWIKQWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:22:36 -0400
Received: from web36615.mail.mud.yahoo.com ([209.191.85.32]:2726 "HELO
	web36615.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932336AbWIKQWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:22:35 -0400
Message-ID: <20060911162234.74678.qmail@web36615.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Mon, 11 Sep 2006 09:22:34 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
To: Joshua Brindle <method@gentoo.org>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
In-Reply-To: <4505508A.1060105@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Joshua Brindle <method@gentoo.org> wrote:

> These 
> capabilities are so course grained I just can't see
> anyone ever using them.

The granularity of the capabilities in the POSIX
DRAFT is targeted at the security policy enforced
by the POSIX P1003.1 interface standard. Anywhere
that P1003.1 says "appropriate privilege" P1003.1e
identifies what that privilege ought to be. The
capability specification also addresses the audit,
MAC and INF portions of P1003.1e. Interfaces
that were outside the scope of P1003.1 at the
time (including, alas, sockets and SVIPC) could
not be included in P1003.1e by rule. Devices
and filesystems, where most of the granularity
issues arise, were excluded.

The 1e DRAFT specifies a granularity that is
appropriate to the kernel and the policies that
the kernel enforces. This is because the
capability mechanism is supposed to be a kernel
protection scheme for kernel objects.
It does not enforce a granularity that is
appropriate to a python based web interface
for financial management systems. That is an
application issue that is much better suited
to application controls like RBAC.



Casey Schaufler
casey@schaufler-ca.com
