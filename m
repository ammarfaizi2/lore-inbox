Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276743AbRJBWPJ>; Tue, 2 Oct 2001 18:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276739AbRJBWPB>; Tue, 2 Oct 2001 18:15:01 -0400
Received: from cs82093.pp.htv.fi ([212.90.82.93]:1920 "EHLO cs82093.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S276738AbRJBWOw>;
	Tue, 2 Oct 2001 18:14:52 -0400
Message-ID: <3BBA3C71.40C3D719@welho.com>
Date: Wed, 03 Oct 2001 01:15:13 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: System reset on Kernel 2.4.10
In-Reply-To: <527872464EC@vcnet.vc.cvut.cz> <20011002234115.A1891@vana.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> I was not able to find where problem could be with unpatched
> kernel, but arguments passed to do_brk(), set into mm->start_brk,
> {start,end}_code and so on looks very suspicious... But as on my
> system it does not crash neither with nor without patch below, I
> leave answer on someone else.

Well, your patch does seem to fix it:

$ /usr/src/linux-2.4.10/vmlinux
Segmentation fault
$ dmesg
...
elf_map error code: -22

Cheers,

	MikaL
