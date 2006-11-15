Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030811AbWKOSYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030811AbWKOSYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030809AbWKOSYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:24:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28593 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030811AbWKOSYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:24:32 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <455B53C7.1060604@mentalrootkit.com> 
References: <455B53C7.1060604@mentalrootkit.com>  <XMMS.LNX.4.64.0611151115360.8593@d.namei> <XMMS.LNX.4.64.0611141618300.25022@d.namei> <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> <15153.1163593562@redhat.com> <26860.1163607813@redhat.com> 
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, trond.myklebust@fys.uio.no,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
       steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be overridden 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 18:21:57 +0000
Message-ID: <1796.1163614917@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:

> > and the race in which the rules might change is still a
> > possibility I have to deal with.
> 
> I don't think this is a race, it is revocation of access. If you check the
> access at every operation and correctly deal with access failures, then this
> shouldn't be a problem. Yes it is a pain, but that is how SELinux is supposed
> to work.

Yes, but what is the correct method of dealing with a failure?  All I can think
of is to SIGKILL the process.

David
