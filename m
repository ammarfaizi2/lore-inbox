Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVJGNDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVJGNDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVJGNDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:03:33 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:1687 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932545AbVJGNDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:03:33 -0400
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <21866.1128676205@warthog.cambridge.redhat.com>
References: <20051006175817.GK16352@shell0.pdx.osdl.net>
	 <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode>
	 <29942.1128529714@warthog.cambridge.redhat.com>
	 <20051005211030.GC16352@shell0.pdx.osdl.net>
	 <23333.1128596048@warthog.cambridge.redhat.com>
	 <21866.1128676205@warthog.cambridge.redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 07 Oct 2005 08:59:34 -0400
Message-Id: <1128689974.1450.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-07 at 10:10 +0100, David Howells wrote:
> I don't know. As far as I know, setxattr and co can be used to set and
> retrieve security data on files. I thought it would be desirable to have
> similar for keys. If not, I can remove both calls/hooks for the time being.

I agree that enabling security-aware applications to separately label
specific keys is desirable, so I'd suggest retaining that support, not
dropping it.  We ultimately need the same support for all kernel objects
(we lost it for sockets and System V IPC when the old SELinux API had to
be dropped).  

-- 
Stephen Smalley
National Security Agency

