Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278979AbRJVVvk>; Mon, 22 Oct 2001 17:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278965AbRJVVvc>; Mon, 22 Oct 2001 17:51:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13072 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278979AbRJVVvS>; Mon, 22 Oct 2001 17:51:18 -0400
Subject: Re: How to read past 8Mb boundary in early boot (i386 arch)?
To: Martin.Bligh@us.ibm.com
Date: Mon, 22 Oct 2001 22:58:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel mailing list)
In-Reply-To: <3034122113.1003761502@mbligh.des.sequent.com> from "Martin J. Bligh" at Oct 22, 2001 02:38:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vn5N-0003Xa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What I guess is needed is to read the pointer to the MPS tables,
> if pointer > 8Mb (well, plus the length of the table or an allowance) 
> then copy it to 7Mb with some phys_memcopy routine. But it seems
> this means handcrafting a page table entry ... in which case, it might 
> be easier to temporarily create a page table for the area pointed to, 
> read it as normal, then tear it down again afterwards?

Take a look at the apictable code added in recent -ac. They have precisely
the same problems to worry about

