Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbTJOQoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbTJOQoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:44:15 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:51727 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S263601AbTJOQoN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:44:13 -0400
Subject: Re: 2.6.0-test7-mm1
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20031015013649.4aebc910.akpm@osdl.org>
References: <20031015013649.4aebc910.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1066232576.25102.1.camel@telecentrolivre>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 15 Oct 2003 13:42:56 -0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew (I again),

Em Qua, 2003-10-15 às 06:36, Andrew Morton escreveu:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test7/2.6.0-test7-mm1

getting this while umounting my /home (ext3) partition:

# umount /dev/hda4

Unable to handle kernel paging request at virtual address c282deac
printing eip:
c0164104
00007063
*pte = 0282d000
Oops: 0002 [#1]
DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[generic_forget_inode+84/352]    Not tainted VLI
EFLAGS: 00010246
EIP is at generic_forget_inode+0x54/0x160
eax: c282dea8   ebx: c6bf4ea0   ecx: c6c2dea8   edx: c6bf4ea8
esi: c6befdf8   edi: c6befdf8   ebp: c244dec8   esp: c244deb4
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 539, threadinfo=c244c000 task=c27239d0)
Stack: c6be7ef8 c244dec8 c0181b74 c6bf4ea0 c6beef38 c244ded8 c0164286 c6bf4ea0 
       c6be7ef8 c244def8 c0196319 c6bf4ea0 00000001 c244def8 c018e560 c7fecb48 
       c6bed400 c244df20 c018a2eb c6be7ef8 c244df0c c244df0c c244df0c c244df0c 
Call Trace:
 [ext3_put_inode+20/48] ext3_put_inode+0x14/0x30
 [iput+86/128] iput+0x56/0x80
 [journal_destroy+153/416] journal_destroy+0x99/0x1a0
 [ext3_xattr_put_super+32/48] ext3_xattr_put_super+0x20/0x30
 [ext3_put_super+43/448] ext3_put_super+0x2b/0x1c0
 [generic_shutdown_super+327/352] generic_shutdown_super+0x147/0x160
 [kill_block_super+29/80] kill_block_super+0x1d/0x50
 [deactivate_super+70/112] deactivate_super+0x46/0x70
 [sys_umount+60/160] sys_umount+0x3c/0xa0
 [sys_oldumount+25/32] sys_oldumount+0x19/0x20
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 8d 53 08 8b 4a 04 39 11 0f 85 0e 01 00 00 8b 43 08 39 50 04 0f 85 f5 
      00 00 00 89 01 c7 43 08 00 01 10 00 89 48 04 a1 dc e4 35 c0 <89> 50 
      04 89 43 08 c7 42 04 dc e4 35 c0 89 15 dc e4 35 c0 ff 05 


-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

