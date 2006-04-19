Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWDSMwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWDSMwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWDSMwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:52:50 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:25784 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750724AbWDSMwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:52:49 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
	 <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 19 Apr 2006 08:56:51 -0400
Message-Id: <1145451411.24289.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 02:40 -0400, Kyle Moffett wrote:
> On Apr 18, 2006, at 21:48:56, Casey Schaufler wrote:
> > --- James Morris <jmorris@namei.org> wrote:
> >> With pathnames, there is an unbounded and unknown number of  
> >> effective security policies on the system, as there are an
> >> unbounded and unknown number of ways of viewing the files via  
> >> pathnames.
> >
> > I agree that for traditional DAC and MAC (including the flavors  
> > supported by SELinux) inodes is the only way to go. SELinux is a  
> > traditional Trusted OS architecture and addresses the traditional  
> > Trusted OS issues.
> 
> Perhaps the SELinux model should be extended to handle (dir-inode,  
> path-entry) pairs.  For example, if I want to protect the /etc/shadow  
> file regardless of what tool is used to safely modify it, I would set  
> up security as follows:

SELinux already provides a way to protect /etc/shadow, in a much
stronger way.  It does require some library/application modifications
(already present in some distros) to preserve a different security label
on files containing shadow data than on files containing public passwd
data, but that is no different than the existing approach for preserving
different file modes on those files.  It doesn't require the kernel to
deal with pathnames itself.

-- 
Stephen Smalley
National Security Agency

