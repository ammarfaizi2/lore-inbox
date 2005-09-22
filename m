Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbVIVFQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbVIVFQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 01:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVIVFQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 01:16:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:64650 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965231AbVIVFQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 01:16:00 -0400
Date: Thu, 22 Sep 2005 06:15:57 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Len Brown <len.brown@intel.com>, zippel@linux-m68k.org,
       viro@ZenIV.linux.org.uk, Eric.Piel@lifl.fr, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bogus #if (acpi/blacklist)
Message-ID: <20050922051557.GH7992@ftp.linux.org.uk>
References: <Pine.LNX.4.61.0509091854500.3743@scrub.home> <1126821915.31252.10.camel@toshiba> <20050921221426.7ccdeac7.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921221426.7ccdeac7.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 10:14:26PM -0700, Randy.Dunlap wrote:
>  obj-y				+= tables.o
> +ifdef CONFIG_X86
>  obj-y				+= blacklist.o
> +endif

More common form would be

obj-$(CONFIG_X86)	+= blacklist.o
