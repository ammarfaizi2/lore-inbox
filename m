Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315219AbSEBSCR>; Thu, 2 May 2002 14:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315227AbSEBSCP>; Thu, 2 May 2002 14:02:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10510 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315219AbSEBSBY>; Thu, 2 May 2002 14:01:24 -0400
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 2 May 2002 19:20:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        rgooch@ras.ucalgary.ca (Richard Gooch), arjanv@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CD169AE.1010206@evision-ventures.com> from "Martin Dalecki" at May 02, 2002 06:30:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173LBU-0004VB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Shared libraries for example don't look up stuff like this inside
> themselfs. (Unless you look at DLL stubs...)

Nor does the kernel. Internal symbols are already resolved

> It's the ld.so programm which maintains such data.
> modutils don't do anything different from classical late binding.

Indeed

> The natural place for such maintainance work could be for example
> the init process, which serves already pretty a similar role for

Well actually the logical place to do it is in modutils. Which is where
we do it right now. We even precompute dependancies with depmod much like
the dynamic link caches

> Another analogy is the rpm dependency maintainance.
> It's the rpm program - which does checking here and not
> the actual application itself during the file-system install.

Actually for dynamic stuff the application also does some of it for late
binding and when triggers are used for relations between packages

All of which says the current modutils method is correct 
