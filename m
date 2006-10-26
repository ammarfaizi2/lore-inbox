Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423178AbWJZKwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423178AbWJZKwJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423233AbWJZKwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:52:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17546 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423178AbWJZKwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:52:06 -0400
Subject: Re: Security issues with local filesystem caching
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, sds@tycho.nsa.gov, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <20061026003202.GH29920@ftp.linux.org.uk>
References: <16969.1161771256@redhat.com>
	 <1161819459.7615.42.camel@localhost.localdomain>
	 <20061026003202.GH29920@ftp.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 11:54:45 +0100
Message-Id: <1161860085.12781.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-26 am 01:32 +0100, ysgrifennodd Al Viro:
> to.  What about access to cache tree by root process that has nothing
> to do with that daemon?  Should it get free access to that stuff, regardless
> of what policy might say about access to cached files?  Or should we at
> least try to make sure that we have the instances in cache no more permissive
> than originals on NFS?

This is already the case however. Root has ptrace, people have /proc
access (even more than before because the chroot check was broken
recently), root has CAP_SYS_RAWIO.


