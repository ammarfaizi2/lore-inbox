Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287359AbSAPTls>; Wed, 16 Jan 2002 14:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287333AbSAPTlh>; Wed, 16 Jan 2002 14:41:37 -0500
Received: from codepoet.org ([166.70.14.212]:15310 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S287303AbSAPTlW>;
	Wed, 16 Jan 2002 14:41:22 -0500
Date: Wed, 16 Jan 2002 12:41:21 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: David Garfield <garfield@irving.iisd.sra.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
Message-ID: <20020116194121.GC32184@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alexander Viro <viro@math.psu.edu>,
	David Garfield <garfield@irving.iisd.sra.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com> <Pine.GSO.4.21.0201152226100.4339-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0201152226100.4339-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jan 15, 2002 at 10:29:12PM -0500, Alexander Viro wrote:
> > Can/will the initramfs mechanism be made to implicitly load into the
> > kernel the modules (or some of the modules) in the image?
> 
> No.  The point of initramfs is to remove crap from kernel and switch
> to using normal code paths for late-boot stuff.  _Adding_ insmod
> analog into the kernel?  No, thanks.

Keep in mind that insmod current needs to incorporate a full ELF
interpreter in userspace (and the source code needs to know about
all the types of relocations and jump for each arch and for 32
and 64 bit ELF.  Horrible stuff really.  If we could cleanup the
kernel's insmod implementation to require merely a syscall
passing a filename to the kernel, it would sure make the
initramfs smaller and simpler.  I believe Rusty made a patch to
do this sort of thing....

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
