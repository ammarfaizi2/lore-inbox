Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbULaGvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbULaGvj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 01:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbULaGvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 01:51:39 -0500
Received: from web60605.mail.yahoo.com ([216.109.118.243]:36509 "HELO
	web60605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261704AbULaGvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 01:51:37 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=OCoqrfG03mecHDBg5MlPO1URIqXU5uW+gAyYfCvGNvZ/Z2WvWxcDeOgERqoA9tOebpAEpJfnrn3C7bEfXonfRKSOPgdA2AUvxfOJUDz+hh4oTBV7FpH+gkbXoneTN/6i2iKO/0z4zdihpU/nVG1dSfku1qtF7/bp7hdUqkEqxNM=  ;
Message-ID: <20041231065136.94485.qmail@web60605.mail.yahoo.com>
Date: Thu, 30 Dec 2004 22:51:36 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Interception for a resource based scheduler
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1104409090.4170.12.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
  I am using these information for the scheduler I am
developing in Linux. The scheduler selects the next
process to run based on the resources needed so that a
high priority process will not starve for a semaphore
key, file lock etc that were acquired by a low
priority process. The user may change the file
descriptor only through syscalls. If I intercept them
and update the resource history that I am maintaining,
then will the information break?

Thanks,
selva

--- Arjan van de Ven <arjan@infradead.org> wrote:

> On Thu, 2004-12-30 at 04:13 -0800, selvakumar
> nagendran wrote:
> > 
> >      Thanks for ur help. The user will be changing
> > this using system calls like dup,dup2 etc. If I
> keep
> > track of all these modifications by intercepting
> all
> > those syscalls and use inode number for
> identifying
> > the structure uniquely, will it break?
> 
> it sure is not a reliable method. The user can
> change the fd's YOU log.
> So your logging is inaccurate. That may or may not
> be a problem, it
> depends on what the application of this is.
> 
> 
> 



		
__________________________________ 
Do you Yahoo!? 
All your favorites on one personal page – Try My Yahoo!
http://my.yahoo.com 
