Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289724AbSAWIFf>; Wed, 23 Jan 2002 03:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289726AbSAWIF1>; Wed, 23 Jan 2002 03:05:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7720 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289724AbSAWIFG>; Wed, 23 Jan 2002 03:05:06 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Bradley D. LaRonde" <brad@ltc.com>, "Thomas Capricelli" <orzel@kde.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently
In-Reply-To: <0ddd01c184b3$ce15c470$5601010a@prefect>
	<066801c183f2$53f90ec0$5601010a@prefect>
	<20011213160007.D998D23CCB@persephone.dmz.logatique.fr>
	<25867.1008323156@redhat.com> <13988.1008348675@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Jan 2002 01:01:47 -0700
In-Reply-To: <13988.1008348675@redhat.com>
Message-ID: <m1elkhfqc4.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> brad@ltc.com said:
> >  That sounds nice, but I cannot imagine how much trouble it would be
> > to implement.
> 
> Adding the pages to the page cache on read_inode() is fairly simple. Hacking 
> the kernel so that readpage() can provide its own page less so.

Well the generic solution is to simply skip readpage and provide (for your fs)
your own versions of generic_file_read and filemap_nopage.  At least
if you want to do it on demand...

Eric

