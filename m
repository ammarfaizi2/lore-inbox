Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287770AbSASWtm>; Sat, 19 Jan 2002 17:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287784AbSASWtc>; Sat, 19 Jan 2002 17:49:32 -0500
Received: from mx1.fuse.net ([216.68.2.90]:28404 "EHLO mta01.fuse.net")
	by vger.kernel.org with ESMTP id <S287770AbSASWtS>;
	Sat, 19 Jan 2002 17:49:18 -0500
Message-ID: <3C49F7DD.7070404@fuse.net>
Date: Sat, 19 Jan 2002 17:49:01 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020112
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext2 module in 2.4.18-pre4 broken?
In-Reply-To: <1011476968.1362.53.camel@psuedomode>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:

>Making ext2 as a module in 2.4.18-pre4 seems to be broken.
>
>
>
>depmod: *** Unresolved symbols in
>/lib/modules/2.4.18-pre4/kernel/fs/ext2/ext2.o
>depmod:         waitfor_one_page
>

Add "EXPORT_SYMBOL(waitfor_one_page);" to linux/kernel/ksyms.c (without 
the quotes).



