Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVAaXcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVAaXcA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVAaXZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:25:30 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:30155 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261432AbVAaXT1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:19:27 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order memory allocations [update]
Date: Tue, 1 Feb 2005 00:19:49 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, Hu Gang <hugang@soulinfo.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200501310019.39526.rjw@sisk.pl>
In-Reply-To: <200501310019.39526.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502010019.49964.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 31 of January 2005 00:19, Rafael J. Wysocki wrote:
> Hi,
> 
> The following patch is (yet) an(other) attempt to eliminate the need for using higher
> order memory allocations on resume.  It accomplishes this by replacing the array
> of page backup entries with a list, so it is only necessary to allocate individual
> memory pages.  This approach makes it possible to avoid relocating many memory
> pages on resume (as a result, much less memory is used) and to simplify
> the assembly code that restores the image.
> 
> The patch is a complement to the patch that I sent some time ago as "swsusp: do not
> use higher order memory allocations on suspend".  It is against 2.6.11-rc2 - on top
> of the previous patch and on top of the "x86_64: Speed up suspend" patch which are
> availble at:
> http://www.sisk.pl/kernel/patches/2.6.11-rc2/swsusp-use-list-suspend-v2.patch
> and at:
> http://www.sisk.pl/kernel/patches/2.6.11-rc2/x86_64-Speed-up-suspend.patch
> respectively.  The patch itself is available at:
> http://www.sisk.pl/kernel/patches/2.6.11-rc2/swsusp-use-list-resume-v1.patch
> and there is a consolidated patch against 2.6.11-rc2 at:
> http://www.sisk.pl/kernel/patches/2.6.11-rc2/2.6.11-rc2-swsusp-use-list.patch

I have updated the patches to include a bugfix from Pavel Machek (thanks, Pavel!).
Affected are the "suspend" patch and the "consolidated" patch.  The updated patches
are available at:
http://www.sisk.pl/kernel/patches/2.6.11-rc2/swsusp-use-list-suspend-v3.patch
http://www.sisk.pl/kernel/patches/2.6.11-rc2/2.6.11-rc2-swsusp-use-list-v2.patch
respectively.  The other patches remain unchanged.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
