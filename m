Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbTEJVBv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 17:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTEJVBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 17:01:51 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:24839 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP id S264508AbTEJVBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 17:01:32 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: The disappearing sys_call_table export.
Date: 10 May 2003 20:48:13 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <b9joid$hv1$1@abraham.cs.berkeley.edu>
References: <Pine.LNX.4.44.0305102217300.1163-100000@marcellos.corky.net>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1052599693 18401 128.32.153.211 (10 May 2003 20:48:13 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 10 May 2003 20:48:13 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoav Weiss  wrote:
>The solution is to have only ONE REAL copy, done by the wrapper.  The
>original syscall will copy from a kernel ptr, unknowingly.  Consider
>the following modified pseudo-code:

Let's see you do sys_execve()...  sys_socketcall() and sys_ioctl() are
fun, too.  (And, I worry about doubly-indirected pointers, for instance.)
It's probably do-able, but you'd better stock up on the Advil in advance:
we're in major headache country, folks.

>Now, don't get me wrong - I still think intercepting the syscall is not
>the right thing to do in this case, since LSM provides hooks in better
>locations.

Right.  LSM seems like a better answer for security applications.
