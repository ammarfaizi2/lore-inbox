Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317249AbSEXUoJ>; Fri, 24 May 2002 16:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315111AbSEXUoI>; Fri, 24 May 2002 16:44:08 -0400
Received: from mail.webmaster.com ([216.152.64.131]:30711 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S315166AbSEXUoH> convert rfc822-to-8bit; Fri, 24 May 2002 16:44:07 -0400
From: David Schwartz <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Fri, 24 May 2002 13:44:03 -0700
In-Reply-To: <20020524105348.T13411@devserv.devel.redhat.com>
Subject: Re: negative dentries wasting ram
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020524204404.AAA21553@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>In glibc 2.3 this will be open("/usr/lib/locale/locale-archive", ), so
>negative dentries won't be useful for glibc locale handling (that
>doesn't mean negative dentries won't be useful for other things, including
>exec?p or searching libraries if $LD_LIBRARY_PATH is used).
>
>    Jakub

	Web servers tend to look for all kinds of things that don't exist. For 
example, if you hit "http://www.mydomain.com/foo" is there a file called 
"foo" in the root document directory? Or is "foo" a directory with an 
"index.html" file in it?

	And what if index files can be "index.html", "index.htm", or "index.cgi"? A 
single URL hit can easily involve looking for five files that don't exist 
before you find the one that does.

	Of course, some web servers have their own internal URL->file mapping 
caches. The ideal solution would be to get rid of the negative dentries we 
aren't using (much? recently?) when we want to get some more free memory.

	DS


