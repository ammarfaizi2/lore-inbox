Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWHYRb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWHYRb6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 13:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWHYRb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 13:31:58 -0400
Received: from xenotime.net ([66.160.160.81]:55782 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751066AbWHYRb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 13:31:58 -0400
Date: Fri, 25 Aug 2006 10:35:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: another NUMA build error
Message-Id: <20060825103507.4f2d193e.rdunlap@xenotime.net>
In-Reply-To: <20060825144350.27530dfb.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060824213559.1be3d60f.rdunlap@xenotime.net>
	<20060825144350.27530dfb.kamezawa.hiroyu@jp.fujitsu.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 14:43:50 +0900 KAMEZAWA Hiroyuki wrote:

> On Thu, 24 Aug 2006 21:35:59 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > Hi,
> > I was just trying to reproduce that 'register_one_node'
> > build error (and couldn't even with the supplied .config file;
> > weird).  Anyway, after I enabled CONFIG_NUMA (but not CONFIG_ACPI),
> > I got the following error message.  Seems that some config
> > options should prevent this config from even being possible
> > to create.  Any ideas or suggestions?
> > 
> Hi, there are 2 ways.
> 
> 1. allow only 2 configs for i386/NUMA
> 	- CONFIG_NUMA + CONFIG_ACPI + CONFIG_ACPI_SRAT
> 	- CONFIG_NUMA + CONFIG_X86_NUMAQ
> 2. allow this and fix include/asm-i386/mmzone.h 
> 	- CONFIG_NUMA + !CONFIG_ACP
> 
> Which is sane ?

I really can't answer that one.  The people who care about
NUMA would have to do that.  It just shouldn't be possible
to make a config with a build error like this.

OK, I prefer option 2 because it is more generic (not hardware-
specific).  Someone else can prefer option 1 because it is
hardware-specific.  :)

---
~Randy
