Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVJHEj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVJHEj5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 00:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVJHEj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 00:39:57 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:1829 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932131AbVJHEj5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 00:39:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DI/7ZwifVj1GLLoeF7MA40kcJdsmgziD8Fnjz6lySX6nFC2ylgs0pYPhJC7YWjaEI+qmCS0vQe+F7qgRZz3XWDEGEL3cqzfwnrVpj2C1KL0+76gLN0cEKsSsG0NbYJYatHl/xv7Y4j0CBryAnUuN7nRcnbbsE3unOHa5AwwOjbY=
Message-ID: <4ae3c140510072139n68b9b2eeyc0a400be32d958fe@mail.gmail.com>
Date: Sat, 8 Oct 2005 00:39:56 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: why is NFS performance poor when decompress linux kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I setup two virtual machines. One works as NFS server and the other is
client. They talk to each other via in-host network communication.

I noticed that when doing large file copy or linux kernel compilation
in a NFS direcotry, the performance is not bad compared to local disk
filesystem such as ext2. However, if I do linux kernel tarball
decompression on a NFS directory, the performance is much worse than
local disk filesystem (over 3 times slower). Anybody know the reason?

My guess is that NFS has to do lookup and getattr over the network,
while local disk filesystem can do that in local memory. Is this the
major reason? or there are some other reasons?

Thanks for help!

-x
