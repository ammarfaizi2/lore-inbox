Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWEIWap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWEIWap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWEIWap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:30:45 -0400
Received: from dvhart.com ([64.146.134.43]:43235 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751285AbWEIWao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:30:44 -0400
Message-ID: <4461180E.4010903@mbligh.org>
Date: Tue, 09 May 2006 15:30:38 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: build failure on 2.6.17-rc3-git15
References: <446010CC.4050908@mbligh.org> <20060509222136.GA12810@mars.ravnborg.org>
In-Reply-To: <20060509222136.GA12810@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, May 08, 2006 at 08:47:24PM -0700, Martin J. Bligh wrote:
> 
>>i386 with this config:
>>http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/numaq
>>
>>scripts/mod/modpost.c: In function `check_sec_ref':
>>scripts/mod/modpost.c:716: error: cast to union type from type not 
>>present in union
>>make[2]: *** [scripts/mod/modpost.o] Error 1
>>make[1]: *** [scripts/mod] Error 2
>>make: *** [scripts] Error 2
>>05/08/06-19:27:02 Build the kernel. Failed rc = 2
>>05/08/06-19:27:02 build: kernel build Failed rc = 1
>>
>>was fine in -git14
>>
>>                        if (hdr->e_ident[EI_CLASS] == ELFCLASS64 &&
>>                            hdr->e_machine == EM_MIPS) {
>>                                r_sym = ELF64_MIPS_R_SYM(rela->r_info);
>>
>>No idea how that got set ...
> 
> The bad commit has been reverted so it should be OK in next (current?)
> -git.

Yup, is fixed. thanks.

M.
