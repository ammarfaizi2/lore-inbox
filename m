Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751907AbWJ3CKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbWJ3CKy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 21:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWJ3CKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 21:10:54 -0500
Received: from main.gmane.org ([80.91.229.2]:45459 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751907AbWJ3CKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 21:10:53 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Frustrated with Linux, Asus, and nVidia, and AMD
Date: Sun, 29 Oct 2006 21:10:41 -0500
Message-ID: <45455F21.6010908@tmr.com>
References: <fa.nWSYbiDM13Z4b2OlxoSzmqud/lI@ifi.uio.no> <fa.NxAEaSXPSQSEviWvGDBmTZn07UE@ifi.uio.no> <fa.i/oIAoig46I/apLGccQ0BesB0W8@ifi.uio.no> <454432DC.9030006@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Andi Kleen <ak@suse.de>
X-Gmane-NNTP-Posting-Host: mail.tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
In-Reply-To: <454432DC.9030006@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Bill Davidsen wrote:
>> 2.6.18 is the latest released kernel, I don't think calling one 
>> release back "ancient" is really advancing the solution. The problem 
>> seems to have been reported in August, and is still not fixed, I do 
>> understand that he would feel there is no progress.
>>
>> How long will you wait before putting in the fix Marc Perkel 
>> suggested, perhaps with a warning logged that it's a band-aid? Many 
>> users will not be astute enough to find this discussion, the bug 
>> report, the fix, configure and build a kernel, etc. And not all 
>> distributions will address it either.
> 
> As far as the "fix" of disabling the skip-ACPI-timer-override, that is 
> not something that can be put in the kernel as it will break other 
> boards that require the ACPI timer override not to be used (like many 
> nForce2 boards for example). Breaking working setups in order to fix 
> others isn't acceptable.
> 
> There are clearly some NVIDIA chipsets which require the override be 
> skipped, and some which require it not be. I think the ball is currently 
> in NVIDIA's court to provide a way of figuring out which chipsets 
> require the quirk and which don't..
> 
The kernel seems to handle lots of other quirks, I agree that this 
should not be the default behavior, but it certainly seems possible to 
catch this on the more common cases for which it is needed.

The boards which need it probably should be the exception, 2.6 kernels 
did without it for several years, and breaking hardware which worked up 
through 2.6.15 is probably not the best way to cope with new boards. I 
don't think ignoring the problem while waiting for nVidia is good 
policy, since it's a regression.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

