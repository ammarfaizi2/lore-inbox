Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVANQX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVANQX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 11:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVANQX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 11:23:57 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:40346 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262018AbVANQX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 11:23:56 -0500
Subject: Re: thoughts on kernel security issues
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105718220.26366.90.camel@moss-spartans.epoch.ncsc.mil>
References: <200501141239.j0ECdaRj005677@laptop11.inf.utfsm.cl>
	 <Pine.LNX.4.58.0501140731450.2310@ppc970.osdl.org>
	 <1105718220.26366.90.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1105719442.26366.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 14 Jan 2005 11:17:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 10:57, Stephen Smalley wrote:
> Just FYI, SELinux does apply checking via the security hooks in mmap and
> mprotect, and can be used to prevent a process from executing anything
> it can write via policy.  
> 
> The TPE security module recently posted to lkml by Lorenzo also tries to
> prevent untrusted users/groups from executing anything outside of
> 'trusted paths', likewise using the security hooks in mmap and mprotect.

More generally, you should be able to easily implement the checking you
describe as a new LSM or even as part of the capability security module,
without requiring any change to the core kernel code.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

