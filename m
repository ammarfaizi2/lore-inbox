Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVKUSkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVKUSkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVKUSkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:40:46 -0500
Received: from web34101.mail.mud.yahoo.com ([66.163.178.99]:24503 "HELO
	web34101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932400AbVKUSkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:40:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AE1/PEM6I6YAM4h4eiYDCtzQgjK2ONCLVaXjQlTQx5UcjVRgiOfu4e/lNtNx00YteCpmXOJW1/ytjR4pDXTJJ8k4jcYCPuB8gK5jXhLugCo/VK032lwYv50waUvPsrpXxLDiBC/x/57khfmufao6Y6IramMmIZXkbjOdBz4V/7U=  ;
Message-ID: <20051121184032.80469.qmail@web34101.mail.mud.yahoo.com>
Date: Mon, 21 Nov 2005 10:40:31 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
To: cel@citi.umich.edu
Cc: Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
In-Reply-To: <438208A1.5020300@citi.umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Chuck Lever <cel@citi.umich.edu> wrote:
> kenny-
> 
> i'm assuming that because you copied trond, this is only reproducible on 
> NFS.  have you tried this test on other local and remote file system types?

Yes, this only applies to NFS.
ext3 doesn't let you use pwrite with O_DIRECT, nor does NFS from 2.6.8.
These are the only 2 filesystem types to which I have access.

For ext3, using ftruncate works just fine for extending the file, but on NFS, ftruncate causes the
non-existent pages to be read in.

-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
