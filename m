Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280134AbRKEDAZ>; Sun, 4 Nov 2001 22:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280132AbRKEDAE>; Sun, 4 Nov 2001 22:00:04 -0500
Received: from [202.108.68.176] ([202.108.68.176]:58794 "HELO
	xteamlinux.com.cn") by vger.kernel.org with SMTP id <S280134AbRKEC7y>;
	Sun, 4 Nov 2001 21:59:54 -0500
Message-ID: <3BE67230.5040006@xteamlinux.com.cn>
Date: Mon, 05 Nov 2001 11:04:16 +0000
From: zmwillow <zmwillow@xteamlinux.com.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:0.9.4) Gecko/20010917
X-Accept-Language: zh, zh-tw, en-us
MIME-Version: 1.0
To: Jakob =?ISO-8859-1?Q?=D8stergaard?= <jakob@unthought.net>
CC: linux-kernel-mail-list <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160MMf-1ptGtMC@fmrl05.sul.t-online.com> <20011104143631.B1162@pelks01.extern.uni-tuebingen.de> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com> <20011104163354.C14001@unthought.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob ?tergaard wrote:

>Here's my stab at the problems - please comment,
>
>We want to avoid these problems:
> 1)  It is hard to parse (some) /proc files from userspace
> 2)  As /proc files change, parsers must be changed in userspace
>
>Still, we want to keep on offering
> 3)  Human readable /proc files with some amount of pretty-printing
> 4)  A /proc fs that can be changed as the kernel needs those changes
>
>
>Taking care of (3) and (4):
>
>Maintaining the current /proc files is very simple, and it offers the system
>administrator a lot of functionality that isn't reasonable to take away now. 
>
>       * They should stay in a form close to the current one *
>
>
>Taking care of (1) and (2):
>
>For each file "f" in /proc, there will be a ".f" file which is a
>machine-readable version of "f", with the difference that it may contain extra
>information that one may not want to present to the user in "f".
>
>The dot-proc file is basically a binary encoding of Lisp (or XML), e.g. it is a
>list of elements, wherein an element can itself be a list (or a character string,
>or a host-native numeric type.  Thus, (key,value) pairs and lists thereof are
>possible, as well as tree structures etc.
>
>All data types are stored in the architecture-native format, and a simple
>library should be sufficient to parse any dot-proc file.
>
>
>So, we need a small change in procfs that does not in any way break
>compatibility - and we need a few lines of C under LGPL to interface with it.
>
>Tell me what you think - It is possible that I could do this (or something
>close) in the near future, unless someone shows me the problem with the
>approach.
>
>Thank you,
>

see http://sourceforge.net/projects/xmlprocfs/
i think this is a good idea that make the kernel output xml format 
informations.


best regards.
zmwillow


