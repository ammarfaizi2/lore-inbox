Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSIOTAb>; Sun, 15 Sep 2002 15:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318188AbSIOTAb>; Sun, 15 Sep 2002 15:00:31 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:29895 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S318184AbSIOTAa>; Sun, 15 Sep 2002 15:00:30 -0400
Subject: Re: [BUG?] binfmt_script: interpreted interpreter doesn't work
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.30.0209151910220.22107-100000@balu>
References: <Pine.GSO.4.30.0209151910220.22107-100000@balu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Sep 2002 22:05:31 +0300
Message-Id: <1032116731.2620.1.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-15 at 20:15, Pozsar Balazs wrote:

> This may well not be bug, rather an intended feature, but please enlighten
> me why the following doesn't work:
> 
> I have two scripts:
> /home/pozsy/a:
> #!/bin/sh
> echo "Hello from a!"
> 
> /home/pozsy/b:
> #!/home/pozsy/a
> echo "hello from b!"
> 
> 
> Both of them has +x permissions.
> But I cannot execute the /home/pozsy/b script:
> 
> [pozsy:~]$ strace -f /home/pozsy/b
> execve("/home/pozsy/b", ["/home/pozsy/b"], [/* 25 vars */]) = 0
> strace: exec: Exec format error
> [pozsy:~]$
> 
> 
> Isn't this "indirection" allowed?

hm... never chcked the code but I think /home/pozsy/a needs to be in
/etc/shells

What are you trying to do, anyway?

Cheers,
Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com
 
 "We don't need kernel hackers or geniuses, we need good developers who
  will do what they're told". Famous last words, the collection.

