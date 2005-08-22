Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbVHVWnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbVHVWnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbVHVWnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:43:01 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21388 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751423AbVHVWm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:42:58 -0400
Date: Mon, 22 Aug 2005 07:21:00 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       jffs-dev@axis.com
Subject: Re: use of uninitialized pointer in jffs_create()
Message-ID: <20050822052100.GA14350@localhost.localdomain>
References: <9a87484905082015284c1686ec@mail.gmail.com> <20050821091401.GA23626@mipter.zuzino.mipt.ru> <9a87484905082104477cae9ba4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9a87484905082104477cae9ba4@mail.gmail.com>
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.10i
X-Junkmail-Status: score=10/50, host=mirapoint5.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090202.43095E1F.0008-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=CF?=	 =?ISO-8859-1?Q?=20=08?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sunday 21 August 2005 a 13:08, Jesper Juhl ecrivait: 
> On 8/21/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > On Sun, Aug 21, 2005 at 12:28:08AM +0200, Jesper Juhl wrote:
> > > gcc kindly pointed me at jffs_create() with this warning :
> > >
> > > fs/jffs/inode-v23.c:1279: warning: `inode' might be used uninitialized
> > > in this function
> > 
> > I don't see a warning with latest gcc-4.1 snapshot.
> > 
> 
> I'm using gcc 3.3.6, and the kernel that shows this warning is 2.6.13-rc6-mm1
>From a copy of the Linus's repository.
stephane@debian:~/devel/linux-2.6$ head -5 Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 13
EXTRAVERSION =-rc6
NAME=Woozy Numbat

stephane@debian:~/devel/linux-2.6/fs/jffs$ grep truncate * -rn
intrep.c:2452:             of the file system if a large file have been
truncated,
stephane@debian:~/devel/linux-2.6/fs/jffs$

Stephane

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
                <stephane.wirtel@gmail.com>


