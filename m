Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310470AbSDCLRR>; Wed, 3 Apr 2002 06:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311147AbSDCLRH>; Wed, 3 Apr 2002 06:17:07 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:37905 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S310470AbSDCLQ5>;
	Wed, 3 Apr 2002 06:16:57 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Robin Johnson <robbat2@fermi.orbis-terrarum.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in compiling 
In-Reply-To: Your message of "Wed, 03 Apr 2002 00:57:06 PST."
             <Pine.LNX.4.43.0204030045510.13140-100000@fermi.orbis-terrarum.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Apr 2002 21:16:46 +1000
Message-ID: <12691.1017832606@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002 00:57:06 -0800 (PST), 
Robin Johnson <robbat2@fermi.orbis-terrarum.net> wrote:
>While mass compiling a new kernel for my slew of systems, I had an unusual
>problem
>
>gcc barfs and gives this huge error:
>gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre4-ac3/include -Wall
>-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
>-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
>-march=i686   -DKBUILD_BASENAME=exec_domain  -DEXPORT_SYMTAB -c
>exec_domain.c
>exec_domain.c:234: parse error before `register_exec_domain'
>exec_domain.c:235: parse error before `unregister_exec_domain'
>exec_domain.c:236: parse error before `__set_personality'
>exec_domain.c:287: parse error before `abi_defhandler_coff'
>...

All EXPORT_SYMBOL.  You would get that behaviour if gcc did not
recognise EXPORT_SYMBOL as a macro.  Probably random data corruption.

