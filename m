Return-Path: <linux-kernel-owner+w=401wt.eu-S1762677AbWLKJTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762677AbWLKJTU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762678AbWLKJTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:19:20 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:38918 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1762677AbWLKJTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:19:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=oGqvoVZ+6g/4oOsYYcOXQ0VAcRZ7tx6m9+s9I/jRepwgK7WnT0eXgllXXSjeT+jggIun3mIcNDy+nOZsZnegyp6HVQGtwcLSN9FOLkqTFyJJdzcIAEDaks9MfWGgpwT6RqEwfpemKAXaxkqCWGmpCuZuU6ZZD/c7v8VHBzwsGVU=  ;
X-YMail-OSG: LhtinV4VM1liv69N0sNGbX_X2QHMNKa6N5a6B6W9jca.8LiPylcSDGdrupdND4bOQz05zrQB2r58y5yWX8rPa6RbJPLf105kvKOZmw0QEvFGMlcH5PAtlQ--
Message-ID: <457D2265.50109@yahoo.com.au>
Date: Mon, 11 Dec 2006 20:18:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-mm1
References: <20061211005807.f220b81c.akpm@osdl.org>
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Temporarily at
> 
> 	http://userweb.kernel.org/~akpm/2.6.19-mm1/
> 
> Will appear later at
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19/2.6.19-mm1/
> 
> 
> - There's some new runtime debugging in kmap_atomic().  It catches one
>   buglet in in ata_scsi_rbuf_get() - there may be others.  If it gets too
>   noisy, please revert kmap_atomic-debugging.patch.
> 
> - The reiser4 build is broken by some VFS changes I made.
> 
> - New git tree git-ubi.patch (Artem Bityutskiy <dedekind@infradead.org>):
> 
>     It is a kind of LVM layer but for flash (MTD) devices which hides
>     flash devices complexities like bad eraseblocks (on NANDs) and wear.  The
>     documentation is available at the MTD web site:
>     http://www.linux-mtd.infradead.org/doc/ubi.html
>     http://www.linux-mtd.infradead.org/faq/ubi.html
> 
> - The x86_64 tree here is a few days old - the server is down.
> 
> - Brought back the write()-deadlock-fix-and-writev-speedup patches.

Note that these still look like they have a couple of problems (you are
_very_ unlikely to hit them unless you are running with CONFIG_DEBUG_VM,
or actually have any useful data).

We're just looking at how to fix them now. Stress testing would be
appreciated, but not your production database.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
