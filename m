Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUH3DW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUH3DW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 23:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUH3DW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 23:22:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:48541 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266344AbUH3DWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 23:22:55 -0400
Date: Sun, 29 Aug 2004 20:21:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1 can't compile a kernel
Message-Id: <20040829202106.181784a3.akpm@osdl.org>
In-Reply-To: <114120000.1093830897@[10.10.2.4]>
References: <114120000.1093830897@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Seems to crap out with file corruption partway through, saying things
>  like:
> 
>  ld -m elf_i386  -r -o utilities.o utalloc.o utcopy.o utdebug.o utdelete.o uteval.o utglobal.o utinit.o utmath.o utmisc.o utobject.o utxface.o
>  uteval.o: file not recognized: File truncated
> 
>  2.6.9-rc1 seems to work fine. You got any likely candidates to try backing
>  out / trying separately? Else I guess I'll try linus.patch.

Yes, rc1-mm1 does everything right apart from reading data from files.

Reverting 

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one-cleanup.patch

then

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one.patch

will help.
