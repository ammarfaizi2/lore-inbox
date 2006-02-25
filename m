Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWBYSIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWBYSIp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 13:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbWBYSIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 13:08:45 -0500
Received: from xenotime.net ([66.160.160.81]:4559 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161036AbWBYSIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 13:08:44 -0500
Date: Sat, 25 Feb 2006 10:09:54 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Zachary Amsden <zach@vmware.com>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, ak@suse.de,
       dhecht@vmware.com, torvalds@osdl.org
Subject: Re: [PATCH] Fix topology.c location
Message-Id: <20060225100954.92fe9425.rdunlap@xenotime.net>
In-Reply-To: <440093C6.4000904@vmware.com>
References: <200602242305.k1ON5Tmb026520@hera.kernel.org>
	<20060225085538.GA17448@redhat.com>
	<440093C6.4000904@vmware.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2006 09:28:38 -0800 Zachary Amsden wrote:

> Dave Jones wrote:
> 
> >This change breaks x86-64 compiles, as it uses the same file.
> >  
> >
> 
> Thanks for fixing that.  Have we decided that file sharing of this sort 
> is a really bad idea yet?  I still see early_printk and  pci-direct.h 
> sharing remains.  If this sharing really must go on, isn't there a less 
> ad-hoc way to do it?  Or at least a mention in the file that "before you 
> modify, note this is shared by arch foo".

I guess a note would be OK, but there are notes already in Makefile*.
oh, or in some .c file if it does #include another.c
or #include ../../arch/other/blah

For i386 and x86_64, currently almost any file could be shared, except for
the cpu-specific ones.

One hurdle to get over seems to be what would Andi accept.

---
~Randy
