Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286221AbSALNSv>; Sat, 12 Jan 2002 08:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286262AbSALNSj>; Sat, 12 Jan 2002 08:18:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:59728 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286221AbSALNSZ>; Sat, 12 Jan 2002 08:18:25 -0500
Date: Sat, 12 Jan 2002 14:17:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
Message-ID: <20020112141738.L1482@inspiron.school.suse.de>
In-Reply-To: <20020112004528.A159@earthlink.net> <a1ooql$ili$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <a1ooql$ili$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Jan 11, 2002 at 11:32:37PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 11:32:37PM -0800, H. Peter Anvin wrote:
> Followup to:  <20020112004528.A159@earthlink.net>
> By author:    rwhron@earthlink.net
> In newsgroup: linux.dev.kernel
> > --- linux.aa2/arch/i386/config.in       Fri Jan 11 20:57:58 2002
> > +++ linux/arch/i386/config.in   Fri Jan 11 22:20:32 2002
> > @@ -169,7 +169,11 @@
> >  if [ "$CONFIG_HIGHMEM64G" = "y" ]; then
> >     define_bool CONFIG_X86_PAE y
> >  else
> > -   bool '3.5GB user address space' CONFIG_05GB
> > +   choice 'Maximum Virtual Memory' \
> > +       "3GB            CONFIG_1GB \
> > +        2GB            CONFIG_2GB \
> > +        1GB            CONFIG_3GB \
> > +        05GB           CONFIG_05GB" 3GB
> >  fi
> 
> Calling this "Maximum Virtual Memory" is misleading at best.  This is
> best described as "kernel:user split" (3:1, 2:2, 1:3, 3.5:0.5);
> "maximum virtual memory" sounds to me a lot like the opposite of what
> your parameter is.

actually it is really max virtual memory.. but from the user point of
view, user is supposed to care about the virtual memory he can manage,
not about what the kernel will do with the rest. So if the user wants
3GB of virtual memory available to each task he will select 3GB. I
really don't mind if you want to change it from the kernel point of
view, but given it's the user who's supposed to compile it, also the
current patch looks good enough to me.

Andrea
