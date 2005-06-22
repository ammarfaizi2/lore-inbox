Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVFVJ0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVFVJ0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVFVJWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:22:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35491 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262945AbVFVJRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:17:38 -0400
Date: Wed, 22 Jun 2005 11:17:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-ID: <20050622091718.GC1863@elf.ucw.cz>
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu> <20050621220619.GC2815@elf.ucw.cz> <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu> <20050621233914.69a5c85e.akpm@osdl.org> <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu> <20050622004902.796fa977.akpm@osdl.org> <E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can we enhance private namespaces so they can squash setuid/setgid?  If so,
> > is that adequate?
> 
> We could.  But that would again be overly restrictive.  The goal is to
> make the use of FUSE filesystems for users as simple as possible.  If
> the user has to manage multiple namespaces, each with it's own
> restrictions, it's becoming a very un-user-friendly environment.

Actually I think this solution is way less ugly. We have precent: if
task is ptraced, suid bits on anything it execs are ignored.

I don't think user interface issues belong to the kernel (and I do not
think different namespaces are that bad for the user; various chroots
and ld_preload hacks already work that way)
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
