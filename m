Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTIGVTz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTIGVTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:19:54 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:49817 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261562AbTIGVTi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:19:38 -0400
Message-ID: <3F5BA1B1.9F2158C2@free.fr>
Date: Sun, 07 Sep 2003 23:22:57 +0200
From: Jerome de Vivie <jerome.devivie@free.fr>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: segfault in ksymoops
References: <32694.1062938650@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Thu, 04 Sep 2003 23:24:24 +0200,
> Jerome de Vivie <jerome.devivie@free.fr> wrote:
> >> I have try ksymoops v2.4.9, v2.4.8 & v2.4.7 and each time i get a
> >> segmentation fault. Here's the output: (the oops file is attached).
> >#5  0x0804e3d1 in Oops_set_default_ta (me=0x82fd5c8 "./ksymoops",
> >ibfd=0x83157f8, options=0xbffff8c0) at oops.c:89
> >        procname = "Oops_set_default_ta"
> >        bt = 0x736b2f2e <Address 0x736b2f2e out of bounds>
> >        bai = (const struct bfd_arch_info *) 0x4008c9a0
> >        t = 1
> >        a = 1
> 
> oops.c::67, the call to bfd_get_target()
>         bt = bfd_get_target(ibfd);      /* Bah, undocumented bfd function */
> is returning garbage.  Ask the binutils people why this is so.

I have try the latest binutils 2.13.1 with no success.

With this version, thoses two lines in the Makefile seems to be mutaly
exclusive:

STATIC := -Wl,-Bstatic
DYNAMIC := -Wl,-Bdynamic

After installing binutils 2.9.5.0.22, it links and work.


Thank you for your support: i've got my oops decoded :)

regards,

j.

-- 
Jérôme de Vivie
