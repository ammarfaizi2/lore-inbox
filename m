Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269964AbUJNEUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269964AbUJNEUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 00:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269966AbUJNEUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 00:20:15 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:22376 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269964AbUJNETR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 00:19:17 -0400
Message-ID: <b2fa632f04101321193488c984@mail.gmail.com>
Date: Thu, 14 Oct 2004 09:49:16 +0530
From: Raj <inguva@gmail.com>
Reply-To: Raj <inguva@gmail.com>
To: eshwar <eshwar@moschip.com>
Subject: Re: Write USB Device Driver entry not called
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <011c01c4b721$b7fd96b0$41c8a8c0@Eshwar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <005101c4b763$5e3cba60$41c8a8c0@Eshwar>
	 <b2fa632f0410122315753f8886@mail.gmail.com>
	 <001401c4b796$abcddfb0$41c8a8c0@Eshwar>
	 <1097663878.4440.0.camel@localhost.localdomain>
	 <004f01c4b8a1$9ee2b6c0$41c8a8c0@Eshwar>
	 <b2fa632f041013203968418d9f@mail.gmail.com>
	 <011c01c4b721$b7fd96b0$41c8a8c0@Eshwar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 09:24:52 +0530, eshwar <eshwar@moschip.com> wrote:
> if I modify the code like this
> 
> char abc;
>                  if(read(fd,&abc,1) < 0)
>                          perror("read to bar failed: ");
>                  close(fd);
> 
> Which will be sucess... This intern states that my file descriptor is right
> .... but write returns EBADF... both are contradicting statements....

It's this simple. File was opened for Read-Only. So for vfs_read it is
a 'good' file
descriptor. And for vfs_write it is a 'BAD' file descriptor. 

-- 
######
raj
######
