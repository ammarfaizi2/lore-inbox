Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbTF3Kcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 06:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbTF3Kcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 06:32:32 -0400
Received: from westhill.hyglo.com ([62.119.43.37]:33202 "EHLO
	westhill.hyglo.com") by vger.kernel.org with ESMTP id S265823AbTF3Kcc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 06:32:32 -0400
Message-ID: <3F00151A.6050302@hyglo.com>
Date: Mon, 30 Jun 2003 12:46:50 +0200
From: peter enderborg <pme@hyglo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: profs open hook
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2003 10:46:51.0218 (UTC) FILETIME=[E9D02320:01C33EF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have done this little patch for the procfs_example.c

diff procfs_example.c 
kernels/linux-2.4.20/Documentation/DocBook/procfs_example.c
87,91d86
< static int open_qp(struct inode * inode, struct file * file)
< {
<   printk("Open my node %p %p \n",inode,file);
<   return -EINVAL;
< }
180c175
<       foo_file->proc_fops->open=open_qp;
---
 >

And when loading this module. The procfs gets broken. I get EINVAL for 
open on
/proc/meminfo and all other procfs info. Why? Should procfs inodes don't 
have full
filesematics? And it don't help to unload the module.

