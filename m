Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290567AbSAYFu0>; Fri, 25 Jan 2002 00:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290566AbSAYFuP>; Fri, 25 Jan 2002 00:50:15 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:32275 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S290544AbSAYFuH>; Fri, 25 Jan 2002 00:50:07 -0500
Date: Fri, 25 Jan 2002 13:55:4 +0800
From: he jian bing <hjbsy@yahoo.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: puzzled by the code : block_write_full_page()
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20020125055011Z290544-13996+11716@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   I have a question with the following kernel code (fs/buffer.c):

   block_write_full_page(struct page *page, get_block_t *get_block)
   {
       ......
       /* OK, are we completely out? */
       if (page->index >= end_index+1 || !offset) {
           UnlockPage(page);
           return -EIO;
       }
       ......
    }

    If the above code is executed, and it return -EIO, where the kernel will use this return
code? and we really arrive here?

thanks.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

