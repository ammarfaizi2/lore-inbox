Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSFISuG>; Sun, 9 Jun 2002 14:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSFISuF>; Sun, 9 Jun 2002 14:50:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11269 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314448AbSFISuE>; Sun, 9 Jun 2002 14:50:04 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] fat/msdos/vfat crud removal
Date: 9 Jun 2002 11:49:47 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ae080b$6bk$1@cesium.transmeta.com>
In-Reply-To: <87r8jhc685.fsf@devron.myhome.or.jp> <200206090709.g5979iK439624@saturn.cs.uml.edu> <20020609114638.J13140@suse.de> <m18z5owd9f.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m18z5owd9f.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
>
> Dave Jones <davej@suse.de> writes:
> 
> > On Sun, Jun 09, 2002 at 03:09:44AM -0400, Albert D. Cahalan wrote:
> > 
> >  > There has been talk of removing __KERNEL__ usage from
> >  > some of the header files.
> > 
> > Where? If anything we need to increase __KERNEL__ usage in headers.
> > We export far too much crap which makes no sense to userspace.
> 
> So we should just remove __KERNEL__ altogether.  And say with 2.5.x
> nothing is exported.  Which pretty much has been the official policy
> since user space started using glibc.
> 
> #include <linux/*>
> and 
> #include <asm/*>
> are no longer supported.
> 

In theory, perhaps.  There is plenty that just really can't be done
that way, especially stuff which deals with ioctls and their
structures.

It makes more sense to constrain what is exported to a minimum, but
actually have it be usable.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
