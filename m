Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315893AbSETL1k>; Mon, 20 May 2002 07:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315913AbSETL1j>; Mon, 20 May 2002 07:27:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45828 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315893AbSETL1i>; Mon, 20 May 2002 07:27:38 -0400
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 20 May 2002 12:47:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <E179c88-0004HH-00@wagner.rustcorp.com.au> from "Rusty Russell" at May 20, 2002 11:38:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179lde-0005PN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Disagree.  May not cause problems at the moment, but a function which
> does:
> 
> 	if (!access_ok (VERIFY_WRITE, to, sizeof(siginfo_t)))
> 		return -EFAULT;
> 	if (from->si_code < 0)
> 		return __copy_to_user(to, from, sizeof(siginfo_t));
> 
> Is clearly wrong,

Its a function that returns non zero for error. Its clearly right. It just
doesn't conform to Rusty's grand vision. 
