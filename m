Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267714AbTAHHVI>; Wed, 8 Jan 2003 02:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbTAHHVI>; Wed, 8 Jan 2003 02:21:08 -0500
Received: from [210.176.202.14] ([210.176.202.14]:51843 "EHLO
	mail.shaolinmicro.com") by vger.kernel.org with ESMTP
	id <S267714AbTAHHVI>; Wed, 8 Jan 2003 02:21:08 -0500
Message-ID: <3E1BD36A.20503@shaolinmicro.com>
Date: Wed, 08 Jan 2003 15:29:46 +0800
From: David Chow <davidchow@shaolinmicro.com>
Organization: Shaolin Microsystems Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: opening a charcter device without using filp_open()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Is it possible to open a character device in kernel space without 
actually openning the device file? Because I don't wan to hold the usage 
count of a particular mount or dcache.

This is what I planned to do,

    struct file fake_devfile = {0};
    struct dentry fake_dentry = {0};
    struct inode fake_inode = {0};

    /* Link up fake file,dentry, inode */
    fake_file.f_dentry=&fake_dentry;
    fake_dentry.d_inode=&fake_inode;

Then I will call the f_op of the character device directly, please give 
advice. Thanks.

regards,
David Chow

