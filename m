Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUBQOc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 09:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUBQOc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 09:32:26 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:23961 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S266206AbUBQOcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 09:32:23 -0500
Subject: Re: Any guides for adding new IDE chipset drivers?
From: Alex Bennee <kernel-hacker@bennee.com>
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1077028026.31892.153.camel@cambridge.braddahead.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Tue, 17 Feb 2004 14:27:06 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 of Febuary 2004 09:40:21 PST, Bart wrote:
>On Monday 16 of February 2004 18:04, Alex Bennee wrote:
>
>> Is there a driver that can be held of as an example of good taste and
>> the "right" way to implement a chipset driver?
>
>Yep.  Please take a look at drivers/ide/arm/icside.c.
>It is well written, quite simple and has DMA support.

Thanks. I'll base my driver on this one as it does seem quite easy
to follow. However I'm wondering what the point of the begin/end functions
are. The dma_read/write functions just seem to call dma_count which starts the
dma requests going.

Am I missing something here? Is all that required from the higher level a single
call to dma_read/write or should I be expecting a series of calls to setup a transfer?


>If you have any questions/issues feel free to ask
>on linux-ide@vger.kernel.org mailing list.

Hmmm, vger seems to be ignoring my subscribe requests. 

Is the list archived anywhere? None are listed on VGER.


-- 
Alex, homepage: http://www.bennee.com/~alex/
It is a hard matter, my fellow citizens, to argue with the belly,
since it has no ears.
		-- Marcus Porcius Cato

