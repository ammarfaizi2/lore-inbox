Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUIBGxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUIBGxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 02:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267512AbUIBGxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 02:53:06 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:609
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S267313AbUIBGxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 02:53:04 -0400
Message-Id: <s136d15f.099@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Thu, 02 Sep 2004 08:53:19 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: question on i386 very early memory detection cleanup patch
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you refer to the 4G/4G split patch - this isn't part of mainline, and
if it needs it would seem it should do this adjustment, not an unrelated
patch. Jan

>>> "H. Peter Anvin" <hpa@zytor.com> 01.09.04 18:20:01 >>>
Jan Beulich wrote:
> Is there a particular reason why this patch changes the alignment of
> cpu_gdt_table to be page rather than cache line aligned? This is
> particulary strange to me because the alignment is guaranteed only
for
> the boot processor, but not for any of the APs; for the latter ones
> there isn't even a string guarantee that the table would be cache
line
> aligned (which it really should be); the weak guarantee only is
through
> an appearant assumption of GDT_ENTRIES being a sufficiently large
power
> of two.
> 
> Thanks, Jan

The 4+4 GB patch apparently needs it.

