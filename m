Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWJAQid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWJAQid (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWJAQid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:38:33 -0400
Received: from xenotime.net ([66.160.160.81]:11963 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751254AbWJAQic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:38:32 -0400
Date: Sun, 1 Oct 2006 09:39:54 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org, rossb@google.com, akpm@google.com, sam@ravnborg.org
Subject: Re: [patch 024/144] allow /proc/config.gz to be built as a module
Message-Id: <20061001093954.8d2aa064.rdunlap@xenotime.net>
In-Reply-To: <200610010627.k916RPIs010370@shell0.pdx.osdl.net>
References: <200610010627.k916RPIs010370@shell0.pdx.osdl.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 23:27:25 -0700 akpm@osdl.org wrote:

> From: Ross Biro <rossb@google.com>
> 
> The driver for /proc/config.gz consumes rather a lot of memory and it is in
> fact possible to build it as a module.
> 
> In some ways this is a bit risky, because the .config which is used for
> compiling kernel/configs.c isn't necessarily the same as the .config which was
> used to build vmlinux.
> 
> But OTOH the potential memory savings are decent, and it'd be fairly dumb to
> build your configs.o with a different .config.

so after getting several disagreements on this, you are going ahead
with it.  I'm disappointed, but I agree that you have a right to
do so.  (IOW, I wouldn't be disappointed if some other patches
were merged even though someone disapproved of them :)

And the memory savings are not a big deal.  You even mentioned that
you had it confused with /proc/kallsyms.

---
~Randy
