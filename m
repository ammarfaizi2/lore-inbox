Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423028AbWJRVsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423028AbWJRVsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423033AbWJRVsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:48:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:19689 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423028AbWJRVsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:48:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=WJaZaEy/ZGCAkKF6hWZbOzY6nXnLf+SqGUK+L49wkyyLVw8IyT97N2CGuqBAL3Ae1U1HMYkWrGOyNuZCyznQ6kiuKYAJV1XJ8F2zBVRNXDfnXFkskSPGja1JNH9IJPavmO/oS+ZJ2Fq4SvNWbxlJwW6kHR9N9xE219XXF+K/n+0=
Date: Thu, 19 Oct 2006 01:48:43 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061018214843.GA5344@martell.zuzino.mipt.ru>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <20061018100057.GB5343@martell.zuzino.mipt.ru> <20061018174257.GP29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018174257.GP29920@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 06:42:57PM +0100, Al Viro wrote:
> On Wed, Oct 18, 2006 at 02:00:57PM +0400, Alexey Dobriyan wrote:
> > > 	Anyway, that patch is obviously preliminary - at the very least
> > > it needs be checked on more configs (and more targets - e.g. mips and
> > > parisc hadn't been checked at all).
> >
> > configs. Is ftp://ftp.linux.org.uk/pub/people/viro/config/ still
> > relevant?
>
> Updated.

Thank you!

This is needed on parisc when sched.h is going out of module.h

lib/random32.c:119: error: `jiffies' undeclared (first use in this function)

--- a/lib/random32.c
+++ b/lib/random32.c
@@ -37,6 +37,7 @@ #include <linux/types.h>
 #include <linux/percpu.h>
 #include <linux/module.h>
 #include <linux/random.h>
+#include <linux/jiffies.h>
 
 struct rnd_state {
 	u32 s1, s2, s3;

