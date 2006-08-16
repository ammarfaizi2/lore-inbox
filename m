Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWHPSfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWHPSfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWHPSfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:35:04 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:28623 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932183AbWHPSfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:35:03 -0400
Date: Wed, 16 Aug 2006 20:35:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@muc.de>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86_64: Re-positioning the bss segment
Message-ID: <20060816183504.GB5852@mars.ravnborg.org>
References: <20060815214952.GB11719@in.ibm.com> <20060816170314.f16f8afa.ak@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816170314.f16f8afa.ak@muc.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 05:03:14PM +0200, Andi Kleen wrote:
 > 
> > o This patch moves the bss at the end hence reducing the size of
> >   bzImage by 896 bytes and size of vmlinux.bin by 600K.
> > 
> > o This change benefits in the context of relocatable kernel patches. If
> >   kernel bss is not part of compressed data (vmlinux.bin) then it does
> >   not have to be decompressed and this area can be used by the decompressor
> >   for its execution hence keeping the memory requirements bounded and 
> >   decompressor code does not stomp over any other data loaded beyond
> >   kernel image (As might be the case with bootloaders like kexec).
> 
> Merged thanks. 
> 
> Does i386 need a similar change?
If it does then I suggest moving the BSS definition to
include/asm-generic/vmlinux.lds.h

	Sam
