Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUBYO5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 09:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUBYO5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 09:57:42 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:40938 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261346AbUBYO5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 09:57:40 -0500
From: Markus Klotzbuecher <mk@creamnet.de>
Reply-To: mk@creamnet.de
To: "Gautam Pagedar" <gautam@cins.unipune.ernet.in>,
       <linux-kernel@vger.kernel.org>
Subject: Re: can i modify ls
Date: Wed, 25 Feb 2004 16:01:50 +0100
User-Agent: KMail/1.5.4
References: <005601c3fd75$1c681510$8c01080a@crayii>
In-Reply-To: <005601c3fd75$1c681510$8c01080a@crayii>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402251601.50489.mk@creamnet.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:89d1891c7eff3dde0c02a5f1254dd9ac
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 February 2004 22:03, Gautam Pagedar wrote:

> working on a project to tweak the working of 'ls' command depending on my
> requirement. I have observed that 'ls' show ALL THE FILES and DIRECTORIES
> in a particular location even though a user has no access rights to it. I
> want to hide all
> such files for that particular user.
>
> The Algorithm i beleive should work like this when an 'ls' command is
> called.
>
> 1. Check the current directory.
> 2. Extract the files or directory to be displayed.
> 3. Check the user permissions for these files.
> 4. Display only those files wher user had either read, write or execute
> access for all owner,group and others.
>
> I have found out that 'ls' uses getdents64() system call for gathering the
> directory information. How do i move ahead from here.

You could do it in the kernel, by using a stackable filesystem and tweaking 
the readdir file operation to do what you want. Then you can mount it on top 
of the root filesystem, and all accesses will pass through it, where you hold 
back the files a user shouldn't see.
On www.filesystems.org you can find bare stackable filesystem templates by 
Erez Zadoc, but maybe you could even use the high level Fist language to 
generate such a filesystem.

Just an idea...

Cheers

	Markus

