Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161137AbVIPIyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161137AbVIPIyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbVIPIyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:54:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:10913 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1161137AbVIPIyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:54:20 -0400
Date: Fri, 16 Sep 2005 01:54:12 -0700
From: Paul Jackson <pj@sgi.com>
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: empty kbuild rebuilding all 2.6.13-mm3 ia64 sn2
Message-Id: <20050916015412.002642a4.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.13-mm3, building for SN2 (an ia64 arch) using sn2_defconfig,
after doing a full successful build, if I just issue another 'make',
it builds more or less every file all over again.  When I am just
working in one *.c file, this causes make to be much more expensive
than it should, rebuilding everything, instead of just that one file
and relinking (or close to that).

No doubt you will need some additional information, unless I get
lucky and you recognize the problem already.

But I don't know what you will be needing, so I'll just have to
wait for the request.

And there is a good chance that it's something bogus on my end.
I say this simply because I don't notice anyone else complaining
about this on lkml, so quite possibly it's just me seeing this.

An empty make begins with:

  CHK     include/linux/version.h
  CC      arch/ia64/kernel/asm-offsets.s
  GEN     include/asm-ia64/asm-offsets.h
  CHK     usr/initramfs_list
  CC      init/main.o
  CC      arch/ia64/mm/init.o
  AS      arch/ia64/ia32/ia32_entry.o
  CC      arch/ia64/sn/kernelsetup.o

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
