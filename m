Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVGDFUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVGDFUp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 01:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVGDFUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 01:20:44 -0400
Received: from [210.76.114.20] ([210.76.114.20]:28083 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S261427AbVGDFUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 01:20:36 -0400
Message-ID: <42C8C7EE.8040906@ccoss.com.cn>
Date: Mon, 04 Jul 2005 13:23:58 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: the magic in do_page_fault() ???
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LKML:

    I am reading code of memory management. this process is so challengable.

    I have one quetion too.

    in do_page_fault() (kernel 2.6.11.11) include one piece of code as
follow:


        if (!down_read_trylock(&mm->mmap_sem)) {
        if ((error_code & 4) == 0 &&
            !search_exception_tables(regs->eip))
            goto bad_area_nosemaphore;
        down_read(&mm->mmap_sem);
    }


    I think I can understand these operations on mm->mmap_sem and
"error_code&4".
but how "search_exception_tables(regs->eip)" work here?

    In "Understanding Linux kernel 2ed" book,  the author say , kernel
must difference two case:

      1. kernel memory access problem.
      2. Arguments of system call include address of memeory unit is
unmapped.

    Well, That is OK. but I want to know what 's mechanism in it ?

    3ks. (in Chinese , number 3 read as 'th' :)


                                                             liyu
                                                                Mon Jul
4 13:23:24 CST 2005






