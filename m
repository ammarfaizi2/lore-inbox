Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbUBHRqi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 12:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUBHRqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 12:46:38 -0500
Received: from main.gmane.org ([80.91.224.249]:52623 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263953AbUBHRqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 12:46:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino notebook
Date: Sun, 08 Feb 2004 12:46:39 -0500
Message-ID: <c05slq$e1r$1@sea.gmane.org>
References: <c05m86$20g$1qsea.gmane.org> <200402081717.i18HH7Ub003181@brain.gnuhh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
In-Reply-To: <200402081717.i18HH7Ub003181@brain.gnuhh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Thinkpad T40 and T41 at least; they suspend & resume properly, but 
there are still interrupt-losing problems when resuming, which is a 
totally separate issue. I believe they both use the 8255PM chipset:

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller 
(rev 03)

There have been a few discussions on the ACPI list about this, as well 
as bugs 1661 and 1409.

Georg C F Greve wrote:
> Do you still remember which notebooks you did _not_ encounter these
> problems with? More particularly which chipsets they had? I've seen so
> many reports for this problem that it would be interesting to know
> where it does _not_ exist.
> 
> The number of notebooks with that problem seems considerable -- people
> reported these problems on different Centrino notebooks from different
> vendors, particularly
> 
>  ASUS M and S series
>  ACER TravelMate
>  IBM Thinkpad R50P
> 
> that all seemed to have precisely one thing in common: the Intel 855GM
> centrino chipset.
> 
> Similar problems have also been reported from Fujitsu-Siemens e6624
> notebook, which has an intel i830 chipset. As the kernel 2.6 currently
> seems to use the i830 AGP driver for the Intel 855GM chipset, those
> two might (or might not) be related.
> 
> That we have not seen more reports is probably because people are
> still mostly using 2.4.x on their notebooks, which was better for
> suspend/resume (I'm using a patched 2.4.24 as I'm writing this).
> 
> Regards,
> Georg

