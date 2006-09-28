Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWI1Emi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWI1Emi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 00:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWI1Emh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 00:42:37 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:3543 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751373AbWI1Emh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 00:42:37 -0400
Message-ID: <451B52B0.1090801@garzik.org>
Date: Thu, 28 Sep 2006 00:42:24 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Illustration of warning explosion silliness
References: <20060928005830.GA25694@havoc.gtf.org>	<20060927183507.5ef244f3.akpm@osdl.org>	<451B29FA.7020502@garzik.org>	<20060927203417.f07674de.akpm@osdl.org>	<451B4D58.9070401@garzik.org> <20060927213628.ef12b1ed.akpm@osdl.org>
In-Reply-To: <20060927213628.ef12b1ed.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> You're ignoring the API issue at hand.  Let me say it again for the 
>> cheap seats:  "search"  You search a list, and stick a pointer somewhere 
>> when found.  No hardware touched.  No allocations.  Real world.  There 
>> is an example of usage in the kernel today.
> 
> If it's called in that fashion then the caller should still check the
> device_for_each_child() return value to find out if it actually got a
> match.


Or in the case of scsi_sysfs.c, it simply <does something>.

Oh well, whatever.  This thing introduces endless build noise we won't 
kill for years, making it much harder to spot much more serious stuff.

	Jeff


