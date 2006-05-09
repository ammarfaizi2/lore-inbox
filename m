Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWEIWVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWEIWVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWEIWVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:21:31 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:25104 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751235AbWEIWVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:21:31 -0400
Date: Wed, 10 May 2006 00:21:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: build failure on 2.6.17-rc3-git15
Message-ID: <20060509222136.GA12810@mars.ravnborg.org>
References: <446010CC.4050908@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446010CC.4050908@mbligh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 08:47:24PM -0700, Martin J. Bligh wrote:
> i386 with this config:
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/numaq
> 
> scripts/mod/modpost.c: In function `check_sec_ref':
> scripts/mod/modpost.c:716: error: cast to union type from type not 
> present in union
> make[2]: *** [scripts/mod/modpost.o] Error 1
> make[1]: *** [scripts/mod] Error 2
> make: *** [scripts] Error 2
> 05/08/06-19:27:02 Build the kernel. Failed rc = 2
> 05/08/06-19:27:02 build: kernel build Failed rc = 1
> 
> was fine in -git14
> 
>                         if (hdr->e_ident[EI_CLASS] == ELFCLASS64 &&
>                             hdr->e_machine == EM_MIPS) {
>                                 r_sym = ELF64_MIPS_R_SYM(rela->r_info);
> 
> No idea how that got set ...
The bad commit has been reverted so it should be OK in next (current?)
-git.
	Sam
