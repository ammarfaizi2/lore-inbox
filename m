Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWHAUO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWHAUO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbWHAUO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:14:29 -0400
Received: from ip-160-218-140-54.eurotel.cz ([160.218.140.54]:8123 "EHLO
	host0.dyn.jankratochvil.net") by vger.kernel.org with ESMTP
	id S1161031AbWHAUO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:14:28 -0400
Date: Tue, 1 Aug 2006 22:13:18 +0200
From: Jan Kratochvil <lace@jankratochvil.net>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060801201318.GA23371@host0.dyn.jankratochvil.net>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <20060801192628.GE7054@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801192628.GE7054@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2006 21:26:28 +0200, Vivek Goyal wrote:
...
> Can't we use the x86_64 relocation approach for i386 as well? I mean keep
> the virtual address space fixed and updating the page tables. This would
> help in the sense that you don't have to change gdb if somebody decides to
> debug the relocated kernel.

This is exactly the approach of mkdump version <=1.0
	http://mkdump.sourceforge.net/
As documented by Itsuro Oda:
	http://mkdump.cvs.sourceforge.net/mkdump/doc/mini_kernel_tech_note.txt?revision=1.1

There is a problem all the drivers expect that allocated buffer address can be
passed directly as physical address to the hardware.  mkdump-1.0 has a lot of
backward-mappings for these drivers but you can never catch all of them.


Regards,
Lace
