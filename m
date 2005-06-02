Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVFBUYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVFBUYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVFBUYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:24:08 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:46468 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S261346AbVFBUWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:22:11 -0400
Message-ID: <429F075F.7030804@keyaccess.nl>
Date: Thu, 02 Jun 2005 15:19:27 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <200506011643.42073.david-b@pacbell.net> <Pine.LNX.4.58.0506020316240.28167@artax.karlin.mff.cuni.cz> <200506011917.14678.david-b@pacbell.net>
In-Reply-To: <200506011917.14678.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

> On Wednesday 01 June 2005 6:23 pm, Mikulas Patocka wrote:
> 
>>Didn't you just forget to set H-bit in exactly one queue head? If there's
>>no entry with H-bit set, controller will loop over list of empty heads
>>again and again.
> 
> 
> Two things:
> 
>  - Why do you ask that?  There's only one QH that _ever_ has that bit set.
>    And it's never removed from the async ring.
> 
>  - The question should be why the schedule is getting turned on in the
>    first place, given there's no work for it to do.
> 
> Until I have some time available to actually look at this, all I can do
> is answer questions and say "hmm, that's strange" given wierd facts.  The
> wierdness here is why that "Async" status bit is ever getting set when
> there's no work for it to do.

I'll be available for testing...

One more data point: I just checked 2.4.31 and it behaves the same.

I also tried checking Windows (98SE) but that may not have been too 
useful. It shows no difference in disk throughput with or without the 
USB2 HDD switched on, but it's only giving me 28 MB/s anyway (on C:, 
which is a 4G VFAT partition right at the end of the disk; the slowest 
part) which might not be enough to notice a misbehaving EHCI controller. 
Also tried giving it a D: partition at the start of the disk, but the 
blasted thing only gave me 16 MB/s there...

Rene.


