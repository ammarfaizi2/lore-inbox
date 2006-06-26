Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWFZBOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWFZBOl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWFZBOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:14:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25013 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964968AbWFZBOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 21:14:38 -0400
Date: Sun, 25 Jun 2006 21:14:24 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Shaohua Li <shaohua.li@intel.com>, Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] swsusp: add architecture special saveable pages support
Message-ID: <20060626011424.GA16497@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Shaohua Li <shaohua.li@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Nigel Cunningham <nigel@suspend2.net>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <200606231501.k5NF1WvU004659@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606231501.k5NF1WvU004659@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 03:01:32PM +0000, Linux Kernel wrote:
 > commit ce4ab0012b32c1a4a1d6e934aeb73bf3151c48d9
 > tree 83b5ba44e93eeb8b72fe14028ac25943f77844fe
 > parent 82dcaafc92fdfbe2c1d6c50b9f5e17d533caf950
 > author Shaohua Li <shaohua.li@intel.com> Fri, 23 Jun 2006 16:04:44 -0700
 > committer Linus Torvalds <torvalds@g5.osdl.org> Fri, 23 Jun 2006 21:42:59 -0700
 > 
 > [PATCH] swsusp: add architecture special saveable pages support
 > 
 > 1. Add architecture specific pages save/restore support.  Next two patches
 >    will use this to save/restore 'ACPI NVS' pages.
 > 
 > 2. Allow reserved pages 'nosave'.  This could avoid save/restore BIOS
 >    reserved pages.
 > 
 > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
 > Cc: Pavel Machek <pavel@ucw.cz>
 > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
 > Cc: Nigel Cunningham <nigel@suspend2.net>
 > Signed-off-by: Andrew Morton <akpm@osdl.org>
 > Signed-off-by: Linus Torvalds <torvalds@osdl.org>

This breaks PPC compiles for me.

kernel/power/snapshot.c: In function 'save_arch_mem':
kernel/power/snapshot.c:93: error: implicit declaration of function 'kmap_atomic_pfn'
kernel/power/snapshot.c:93: warning: assignment makes pointer from integer without a cast

		Dave

-- 
http://www.codemonkey.org.uk
