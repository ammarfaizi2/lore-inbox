Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUGJUok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUGJUok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 16:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266431AbUGJUok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 16:44:40 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:53450 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266427AbUGJUoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 16:44:38 -0400
Message-ID: <c26fd82804071013442f4c1447@mail.gmail.com>
Date: Sat, 10 Jul 2004 15:44:31 -0500
From: Qiuyu Zhang <qiuyu.zhang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question about copy_from_user/copy_to_user
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am working on a module driver. A user application alloc a bunch of
memory for storing packet. And module driver can read /write data
from/into the memory in user space. I use ioctl function to pass the
pointer of memory of user space to module driver.  What I want to do
is to store the pointer in kernel space and when I need to write or
read data from memory of user space, I try to use copy_from_user or
copy_to_user to get/put data. But I always get wrong data. I don't
know the reason. Would you guys give me some help?

Simple description of the code:

device_ioctl() {
     // get the pointer of memory of user space, and assign the
pointer to kernel variable.
}



device_xmit(){
     // when upper layer send a packet to this device.
     //  I try to use the copy_from_user to get some information from
user space buf
     // but I cannot get correct information.   
}

Thx
