Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWHYFlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWHYFlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 01:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWHYFlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 01:41:16 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:43679 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965080AbWHYFlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 01:41:15 -0400
Date: Fri, 25 Aug 2006 14:43:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: another NUMA build error
Message-Id: <20060825144350.27530dfb.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060824213559.1be3d60f.rdunlap@xenotime.net>
References: <20060824213559.1be3d60f.rdunlap@xenotime.net>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006 21:35:59 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> Hi,
> I was just trying to reproduce that 'register_one_node'
> build error (and couldn't even with the supplied .config file;
> weird).  Anyway, after I enabled CONFIG_NUMA (but not CONFIG_ACPI),
> I got the following error message.  Seems that some config
> options should prevent this config from even being possible
> to create.  Any ideas or suggestions?
> 
Hi, there are 2 ways.

1. allow only 2 configs for i386/NUMA
	- CONFIG_NUMA + CONFIG_ACPI + CONFIG_ACPI_SRAT
	- CONFIG_NUMA + CONFIG_X86_NUMAQ
2. allow this and fix include/asm-i386/mmzone.h 
	- CONFIG_NUMA + !CONFIG_ACP

Which is sane ?

-KameI


