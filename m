Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUAJQZw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUAJQZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:25:52 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:39830 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265253AbUAJQZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:25:49 -0500
Message-ID: <40002758.7020705@BitWagon.com>
Date: Sat, 10 Jan 2004 08:24:56 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2. ELF loader mystery
References: <20040110145329.36ecaa38@argon.inf.tu-dresden.de>	<4000135C.4060008@BitWagon.com> <20040110161936.57954de8@argon.inf.tu-dresden.de>
In-Reply-To: <20040110161936.57954de8@argon.inf.tu-dresden.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JR> Yes, there was an interpretation of ELF that p_filesz < p_memsz implied .bss
JR> only for the last PT_LOAD in the array of Elf32_Phdr.  Later this was changed
JR> so that .bss applied only on the PT_LOAD with the highest p_vaddr, regardless
JR> of position in Elf32_Phdr. ...

Udo> Where did this interpretation come from? The ELF standard (1.2) I'm looking at
Udo> from: http://x86.ddj.com/ftp/manuals/tools/elf.pdf says ...

Diffusion can be a slow and erratic process, resulting in "bugs."  "The ELF
standard" (there have been different versions) was not widely available,
and/or not widely consulted, for some parts of its lifetime.
Also, the standard contains some generalizations that were not common usage;
common usage was [is] .text < .data < .bss, with single pieces of each.

-- 

