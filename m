Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288799AbSAIFBl>; Wed, 9 Jan 2002 00:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288803AbSAIFBc>; Wed, 9 Jan 2002 00:01:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24327 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288799AbSAIFBU>; Wed, 9 Jan 2002 00:01:20 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] klibc requirements
Date: 8 Jan 2002 21:01:16 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1giqs$93d$1@cesium.transmeta.com>
In-Reply-To: <20020108192450.GA14734@kroah.com> <20020109042331.GB31644@codeblau.de> <20020109045109.GA17776@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020109045109.GA17776@kroah.com>
By author:    Greg KH <greg@kroah.com>
In newsgroup: linux.dev.kernel
>
> On Wed, Jan 09, 2002 at 05:23:31AM +0100, Felix von Leitner wrote:
> > My understanding of what "initramfs programs" actually means is vague at
> > best.  Are these just programs that are intended to work in an initial
> > ram disk?  Or is it a special collection that is included in the kernel
> > distribution?
> 
> I don't know if they will be included in the kernel distribution or not.
> But they will be part of the kernel build process, if only to copy them
> to the ramfs image which is then added to the kernel image.
> 

Why should it be included in the kernel image?  That's not the current
plan, as far as I know.  It should be a separate file or set of files
loaded by the bootloader (using an enhanced initrd protocol backward
compatible with old bootloaders.)  Of course, it might be convenient
to have them come out of the same source distribution, but that's
really an unrelated issue.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
