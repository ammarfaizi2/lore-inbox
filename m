Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422670AbWBIABL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbWBIABL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 19:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbWBIABL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 19:01:11 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:56523 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1422670AbWBIABK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 19:01:10 -0500
Subject: Re: file system question
From: Avishay Traeger <atraeger@cs.sunysb.edu>
To: kapil a <kapilann@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ef2d59350602081539w7b6780e3mf6d8326f6d4963f2@mail.gmail.com>
References: <ef2d59350602081539w7b6780e3mf6d8326f6d4963f2@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 19:01:08 -0500
Message-Id: <1139443268.4902.11.camel@rockstar.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 18:39 -0500, kapil a wrote:
> I am trying to write a file system for 2.6.  I have written the
> required things to mount my file system and now i am trying to get
> some f_op's and d_op's. I was trying to make the 'ls' command work. So
> i wrote a myfs_readdir() and linked it to the f_op field. My routine
> gets called and also filldir gets called and stores the data in the
> dirent but i dont get the output in stdout.
> 
>   On using strace i find that "ls" does not perform all the calls that
> a "ls" in a directory mountedf in ext2 performs. To be specific, the
> strace ouput ends after the getdents64 system call. In the normal "ls"
> strace, i find there are a couple of more system calls namely a fstat
> followed by a write to stdout and some more mmap calls.

Correct.  The getdents system call will call your readdir function.

>   I dont understand the reason behind why the write is not called. My
> guess is i have not over-ridden some function that i have to write as
> part of my file system instead of using the default method.

Why would your write function get called when 'ls' writes to stdout?
Please explain your question more clearly.


Avishay Traeger
http://www.fsl.cs.sunysb.edu/~avishay/

