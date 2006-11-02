Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWKBSFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWKBSFe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWKBSFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:05:34 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:32938 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751367AbWKBSFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:05:33 -0500
Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: David Howells <dhowells@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <1162484964.6503.9.camel@localhost.localdomain>
References: <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com>
	 <1162396705.29617.18.camel@localhost.localdomain>
	 <1162403134.32614.242.camel@moss-spartans.epoch.ncsc.mil>
	 <1162484964.6503.9.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 02 Nov 2006 13:04:16 -0500
Message-Id: <1162490657.5519.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 11:29 -0500, Karl MacMillan wrote:
> On Wed, 2006-11-01 at 12:45 -0500, Stephen Smalley wrote:
> > On Wed, 2006-11-01 at 10:58 -0500, Karl MacMillan wrote:
> 
> <snip>
> 
> 
> > > fssid seems like the wrong name, though it does match the DAC concept.
> > > This is really more general impersonation of another domain by the
> > > kernel and might have other uses.
> > 
> > NFS will want a fssid in order to have file access checks applied
> > against the client process' SID if/when the client process' context
> > becomes available.
> 
> I was suggesting that it might be helpful if this applied to all checks
> - not just file access - and would therefore need a different name.

Not all checks (e.g. not when checking the ability of another task to
send a signal to the task), but all checks where the task SID is used as
the subject/source.

-- 
Stephen Smalley
National Security Agency

