Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUFHJRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUFHJRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUFHJRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:17:21 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:58816 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S264914AbUFHJRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:17:20 -0400
Date: Tue, 8 Jun 2004 11:17:17 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc3
Message-ID: <20040608091717.GA601@ii.uib.no>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This failed to build for me:

% make oldconfig; make
<snip>
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/mach-generic/built-in.o(.init.text+0x39e): In function `parse_unisys_oem':
: undefined reference to `platform_rename_gsi'
make: *** [.tmp_vmlinux1] Error 1

So I switched from the default CONFIG_X86_GENERICARCH to
CONFIG_X86_PC, which is probably the more correct option for my system
(dual Pentium-III, 2 GB memory). Then it built just fine. 


  -jf
