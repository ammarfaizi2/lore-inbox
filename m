Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbUAIToI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbUAIToI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:44:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:54163 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264144AbUAIToF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:44:05 -0500
Date: Fri, 9 Jan 2004 11:44:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: ornati@lycos.it, gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Message-Id: <20040109114437.550fa5f4.akpm@osdl.org>
In-Reply-To: <1073675705.14637.8.camel@dyn319250.beaverton.ibm.com>
References: <200401021658.41384.ornati@lycos.it>
	<200401071559.16130.ornati@lycos.it>
	<1073503421.10018.17.camel@dyn319250.beaverton.ibm.com>
	<200401072112.35334.ornati@lycos.it>
	<20040107155729.7e737c36.akpm@osdl.org>
	<1073610357.12720.20.camel@dyn319250.beaverton.ibm.com>
	<20040108171728.54a72cf7.akpm@osdl.org>
	<1073675705.14637.8.camel@dyn319250.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> 1) see whether you see a regression with files replacing the 
>     cat command in your script with
>         dd if=big_file of=/dev/null bs=1M count=256

You'll need to unmount and remount the fs in between to remove the file
from pagecache.  Or use fadvise() to remove the pagecache.  There's a
little tool which does that in 

http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz

