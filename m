Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280028AbRKDQn0>; Sun, 4 Nov 2001 11:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280027AbRKDQnR>; Sun, 4 Nov 2001 11:43:17 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:3240 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280026AbRKDQnB>; Sun, 4 Nov 2001 11:43:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Jakob =?iso-8859-1?q?=D8stergaard=20?= <jakob@unthought.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 17:45:45 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com> <20011104163354.C14001@unthought.net>
In-Reply-To: <20011104163354.C14001@unthought.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <160QM5-1HAz5sC@fmrl00.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 November 2001 16:33, you wrote:
> Maintaining the current /proc files is very simple, and it offers the
> system administrator a lot of functionality that isn't reasonable to take
> away now.
>        * They should stay in a form close to the current one *

I doubt that it is worthwhile to keep them in the current form for any other 
reason than compatibility (with existing software and people's habits). 
It doesn't make sense to describe things in 200 different formats, you won't 
help anybody with that. It also violates the good old principle of keeping 
policy out of the kernel. And, for me, layout is clearly policy.

The reason for proc's popularity is clearly that you can use any tool, from 
cat over more/less to the text editor of choice, and read the files. There 
should be ways to achieve this without putting things into the kernel.  Is 
there is a way to implement a filesystem in user-space? What you could do is 
to export the raw data using single-value-files, XML or whatever and then 
provide an emulation of the old /proc files and possibly new ones in user 
space. This could be as simple as writing a shell-script for each emulated 
file.


> The dot-proc file is basically a binary encoding of Lisp (or XML), e.g. it
> is a list of elements, wherein an element can itself be a list (or a

Why would anybody want a binary encoding? 
It needs special parsers and will be almost impossible to access from shell 
scripts. 

bye...
