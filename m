Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWDRVI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWDRVI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 17:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWDRVI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 17:08:59 -0400
Received: from mx1.suse.de ([195.135.220.2]:54435 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750947AbWDRVI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 17:08:58 -0400
Date: Tue, 18 Apr 2006 14:07:23 -0700
From: Greg KH <greg@kroah.com>
To: Crispin Cowan <crispin@novell.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060418210723.GC9171@kroah.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> <1145381250.19997.23.camel@jackjack.columbia.tresys.com> <44453E7B.1090009@novell.com> <1145391252.16632.231.camel@moss-spartans.epoch.ncsc.mil> <44454DA4.90902@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44454DA4.90902@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 01:35:48PM -0700, Crispin Cowan wrote:
> > - Ease of use should be addressed in the user interface, not by using a
> > broken kernel mechanism.   There is ongoing work to address the
> > useability of SELinux in userspace; it doesn't require changing the
> > kernel mechanism to rely on pathnames (which is broken).
> >   
> Mediating by file names rather than inodes is the fundamental place
> where we disagree.

The main problem with "mediating by file names" in Linux these days is
(as I'm sure you know) the whole fun of binds, namespaces and other
lovely things that people do with filesystems (see the fun that
ClearCase does with bind mounts on the latest 2.6 kernel for an example
of the nightmare that "file names" will cause.)

Yes, users are used to filenames, but fortunatly they don't matter to
the kernel.

> I am delighted with LSM, because it allows us to disagree without
> having to fight about it.

LSM doesn't care about filenames, but inodes.  So you both are not
disagreeing :)

thanks,

greg k-h
