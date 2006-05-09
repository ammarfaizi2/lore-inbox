Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWEIDrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWEIDrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 23:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWEIDrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 23:47:31 -0400
Received: from dvhart.com ([64.146.134.43]:28642 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750943AbWEIDra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 23:47:30 -0400
Message-ID: <446010CC.4050908@mbligh.org>
Date: Mon, 08 May 2006 20:47:24 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: build failure on 2.6.17-rc3-git15
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 with this config:
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/numaq

scripts/mod/modpost.c: In function `check_sec_ref':
scripts/mod/modpost.c:716: error: cast to union type from type not 
present in union
make[2]: *** [scripts/mod/modpost.o] Error 1
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2
05/08/06-19:27:02 Build the kernel. Failed rc = 2
05/08/06-19:27:02 build: kernel build Failed rc = 1

was fine in -git14

                         if (hdr->e_ident[EI_CLASS] == ELFCLASS64 &&
                             hdr->e_machine == EM_MIPS) {
                                 r_sym = ELF64_MIPS_R_SYM(rela->r_info);

No idea how that got set ...

