Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWHWPOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWHWPOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWHWPOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:14:32 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:17456 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S964971AbWHWPOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:14:32 -0400
Subject: Re: [PATCH] Translate asm version of ELFNOTE macro into
	preprocessor macro
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Virtualization <virtualization@lists.osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <44EC6B12.4060909@goop.org>
References: <1156333761.12949.35.camel@localhost.localdomain>
	 <44EC6B12.4060909@goop.org>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 16:14:34 +0100
Message-Id: <1156346074.12949.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2006 15:16:19.0781 (UTC) FILETIME=[16138F50:01C6C6C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 07:49 -0700, Jeremy Fitzhardinge wrote:
> Ian Campbell wrote:
> > The first is that older gas does not support :varargs in .macro
> > definitions (in my testing 2.17 does while 2.15 does not, I don't know
> > when it became supported). The Changes file says binutils >= 2.12 so I
> > think we need to avoid using it. There are no other uses in mainline or
> > -mm. Old gas appears to just ignore it so you get "too many arguments"
> > type errors.
> >   
> OK, seems reasonable.  Eric Biederman solved this by having NOTE/ENDNOTE 
> (or something like that) in his "bzImage with ELF header" patch, but I 
> don't remember it being used in any way which is incompatible with using 
> a CPP macro.

I can't find that patch, does NOTE/ENDNOTE just do the push/pop .note
section?

That would solve the problem with the first argument of the macro being
a string but the final argument could still be for .asciz note contents.

Ian.


