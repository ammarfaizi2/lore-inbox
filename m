Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVIVDi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVIVDi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 23:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbVIVDi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 23:38:28 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:670 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030203AbVIVDi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 23:38:28 -0400
Subject: Re: [PATCH] bogus #if (acpi/blacklist)
From: Len Brown <len.brown@intel.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: viro@ZenIV.linux.org.uk, Eric Piel <Eric.Piel@lifl.fr>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0509091854500.3743@scrub.home>
References: <Pine.LNX.4.61.0509091854500.3743@scrub.home>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 18:05:15 -0400
Message-Id: <1126821915.31252.10.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 12:55 -0400, Roman Zippel wrote:
> Hi,
> 
> On Fri, 9 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> 
> > Sigh...  It should be left as #if, of course, but I suspect that
> cleaner way to
> > deal with that would be (in Kconfig)
> >
> > config ACPI_BLACKLIST_YEAR
> >         int "Disable ACPI for systems before Jan 1st this year" if
> X86
> >         default 0
> 
> That would be indeed the better fix.

The real bug is that drivers/acpi/blacklist.c (the only place
CONFIG_ACPI_BLACLIST_YEAR is referenced) is compiled for non X86.

-Len


