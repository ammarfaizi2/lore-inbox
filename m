Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVHNUJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVHNUJW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 16:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVHNUJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 16:09:21 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:12503 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932088AbVHNUJV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 16:09:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ba6Do/P5L+wwmXCp8n+Vb++GDsfGYqmltw08Oo+EsKvfAM68qHsT5DqtK+jKvc6hDgIbzkKrLzRXKeBlfkeKbzEhfIGrPXeUf+a3druHEdTFdE0EuBtfPEFdc7mt0u73pW0WIUUV6yfuaAZnSVYJp4Lr/U5G8TpLKs9F/T/DfvA=
Message-ID: <4fec73ca050814130916b78a57@mail.gmail.com>
Date: Sun, 14 Aug 2005 22:09:20 +0200
From: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Implementing a network based filesystem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I continue studying the VFS interface. As I said in previous e-mails,
my goal is to integrate an existing parallel filesystem into the Linux
kernel.

Now, I am looking for a reduced subset of operations to focus on. I
have selected the following:
  struct file_system_type
    get_sb()
  struct super_operations
    read_inode()
    write_inode()
    delete_inode()
    write_super()
  struct inode_operations
    *none*
  struct dentry_operations
    *none*
  struct file_operations
    read()
    write()

Methods that are not in the listing will be replaced by generic
functions. I think that the enumerated methods are what it is needed
to make this network based filesystem work (without taking in account
other requirements of the filesystem).

I would appreciate corrections about this listing in case I have
forget some important method.

Regards,

-- 
Guillermo
