Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVANQFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVANQFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 11:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVANQFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 11:05:35 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:31896 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262015AbVANQFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 11:05:30 -0500
Subject: Re: thoughts on kernel security issues
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501140731450.2310@ppc970.osdl.org>
References: <200501141239.j0ECdaRj005677@laptop11.inf.utfsm.cl>
	 <Pine.LNX.4.58.0501140731450.2310@ppc970.osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1105718220.26366.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 14 Jan 2005 10:57:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 10:45, Linus Torvalds wrote:
> (or just add a security hook there - it's not like this couldn't be a 
> SELinux thing..)
> 
> And no, this doesn't trap mprotect(), but that's not the point. The point
> of this is not to make it impossible to execute code on purpose by some
> existing binary - it's to make it impossible for some people to compile or
> download their own binaries.

Just FYI, SELinux does apply checking via the security hooks in mmap and
mprotect, and can be used to prevent a process from executing anything
it can write via policy.  

The TPE security module recently posted to lkml by Lorenzo also tries to
prevent untrusted users/groups from executing anything outside of
'trusted paths', likewise using the security hooks in mmap and mprotect.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

