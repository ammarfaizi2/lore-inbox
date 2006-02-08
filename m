Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWBHXj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWBHXj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWBHXj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:39:29 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:44922 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422638AbWBHXj3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:39:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H8UJGvqVVXQw8w63Le2BCGbM1pSPndTuwVdBG0LavjzjBfRPJDZ6UlYKE/kjWNm4IM4qnR1lOr652CYUbApizSDQ2JMbcG+BDiFhhoSZDweIZzjOVq1vtDYmU51K8S1nOPJ3rysxy5uVJgSuXGPq5bxXTWGzUaOtFfz5vo251U0=
Message-ID: <ef2d59350602081539w7b6780e3mf6d8326f6d4963f2@mail.gmail.com>
Date: Wed, 8 Feb 2006 18:39:28 -0500
From: kapil a <kapilann@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: file system question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to write a file system for 2.6.  I have written the
required things to mount my file system and now i am trying to get
some f_op's and d_op's. I was trying to make the 'ls' command work. So
i wrote a myfs_readdir() and linked it to the f_op field. My routine
gets called and also filldir gets called and stores the data in the
dirent but i dont get the output in stdout.

  On using strace i find that "ls" does not perform all the calls that
a "ls" in a directory mountedf in ext2 performs. To be specific, the
strace ouput ends after the getdents64 system call. In the normal "ls"
strace, i find there are a couple of more system calls namely a fstat
followed by a write to stdout and some more mmap calls.

  I dont understand the reason behind why the write is not called. My
guess is i have not over-ridden some function that i have to write as
part of my file system instead of using the default method.

  Any help regarding this would be appreciated...

  regards
  kaps
