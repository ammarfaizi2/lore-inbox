Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbSAXJrR>; Thu, 24 Jan 2002 04:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbSAXJrI>; Thu, 24 Jan 2002 04:47:08 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:29452 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S286303AbSAXJqt>; Thu, 24 Jan 2002 04:46:49 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
In-Reply-To: <20020123121819.GD965@elf.ucw.cz>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.17-686-smp (i686))
Message-Id: <E16TgSj-0001OK-00@gondolin.me.apana.org.au>
Date: Thu, 24 Jan 2002 20:46:29 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:

>> How is linking back a file into the normal namespace anymore
>> a security hole as having it under /proc or keeping an fd to it
>> open?

> Imagine you want to delete my file, you are root.

> Before, you could rm it, then kill all my processes.

No you can't.  Your processes may be in a tight loop making new links
for the file.  The only safe solution is to kill the processes first,
then delete the file.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
