Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUGGUt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUGGUt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUGGUt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:49:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:47065 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265462AbUGGUtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:49:08 -0400
Date: Wed, 7 Jul 2004 13:48:52 -0700 (PDT)
From: Bryce Harrington <bryce@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: <wli@holomorphy.com>, <ltp-list@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <testdev@osdl.org>
Subject: Re: [LTP] Re: Recent changes in LTP test results
In-Reply-To: <20040706191009.279aed14.akpm@osdl.org>
Message-ID: <Pine.LNX.4.33.0407071334460.22452-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004, Andrew Morton wrote:
> Bryce Harrington <bryce@osdl.org> wrote:
> >
> > The results listing has been updated.
> >
> >      http://developer.osdl.org/bryce/ltp/
> >
> >  Briefly:
> >
> >  Patch Name           TestReq#    CPU  PASS  FAIL  WARN  BROK
> > ...
> >  2.6.7-mm6              294691  2-way  7178    46     3     6
>
> Again, these tests do not fail for me, with ltp-full-20040603
>
>
> vmm:/mnt/hda5/ltp-full-20040603> ./testcases/bin/access03
> access03    1  PASS  :  access((char *)-1,R_OK) failed as expected with errno 14 (EFAULT) : Bad address
> access03    2  PASS  :  access((char *)-1,W_OK) failed as expected with errno 14 (EFAULT) : Bad address
...
>
> Can you please retest with ltp-full-20040603 and, if it still fails,
> send me the .config and a description of the system and the compiler
> version used to build the kernel?

Hi Andrew,

I have retested with ltp-full-20040603.  This version of LTP hangs on
our system but fortunately completes most of the tests before doing so.
It indicates that it still encounters the same errors, e.g.:

access03       1   FAIL : access((char *)-1,R_OK) failed with errno 2 : No such file or directory but expected 14 (EFAULT)
access03       2   FAIL : access((char *)-1,W_OK) failed with errno 2 : No such file or directory but expected 14 (EFAULT)
...


Here is the .config, system description, compiler version, and other info:

Full results:      http://khack.osdl.org/stp/294760/

Kernel config:     http://khack.osdl.org/stp/294760/environment/kernel-config

System desc:       http://khack.osdl.org/stp/294760/environment/machine_info
                   http://khack.osdl.org/stp/294760/environment/System_Information-after.txt

RH9 Pkg upgrades:  http://khack.osdl.org/stp/294760/environment/package-upgrades

Syslog:            http://khack.osdl.org/stp/294760/environment/syslog-capture

Compiler and other tools:
    Distro                 Red Hat Linux release 9 (Shrike)
    Kernel                 Linux stp1-003 2.6.7-bk19 #1 Wed Jul 7 11:17:10 PDT 2004
    Compiler               gcc (GCC) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
    Gnu make               3.79.1
    util-linux             2.11y
    mount                  2.11y
    modutils               2.4.22
    e2fsprogs              1.32
    pcmcia-cs              3.1.31
    PPP                    2.4.1
    isdn4k-utils           3.1pre4
    Linux C Library        2.3.2
    Dynamic linker (ldd)   2.3.2
    Procps                 2.0.11
    Net-tools              1.60
    Kbd                    1.08
    Sh-utils               4.5.3

Thanks,
Bryce

