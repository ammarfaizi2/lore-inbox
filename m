Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSFGI6B>; Fri, 7 Jun 2002 04:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSFGI6A>; Fri, 7 Jun 2002 04:58:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10907 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317251AbSFGI6A>;
	Fri, 7 Jun 2002 04:58:00 -0400
Date: Fri, 07 Jun 2002 01:54:18 -0700 (PDT)
Message-Id: <20020607.015418.127179640.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E179PZF-0003gC-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Sun, 19 May 2002 13:13:41 +0100 (BST)

   > arch/sparc/kernel/sys_sunos.c:481:	ret = copy_to_user(&name->sname[0], &system_utsname.sysname[0], sizeof(name->sname) - 1);
   
   Very broken.
   
   > arch/sparc64/kernel/sys_sparc32.c:3675:	return copy_to_user(res32, kres, sizeof(*res32));
   
   Looks very borked in several other spots

I've taken care of these bits in my tree and double checked each file
in it's entirety.

