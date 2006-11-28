Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965823AbWK1UPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965823AbWK1UPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965885AbWK1UPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:15:10 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35303 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965818AbWK1UPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:15:08 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <456C98B4.9010405@s5r6.in-berlin.de>
Date: Tue, 28 Nov 2006 21:14:44 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061113 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Robert Crocombe <rcrocomb@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: ieee1394: host adapter disappears on 1394 bus reset
References: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>	 <4564C4C7.5060403@s5r6.in-berlin.de>	 <e6babb600611221628nd9430c6pe3ab36e9862b3b6d@mail.gmail.com>	 <e6babb600611270739k27e1ed51va3cd82ccfa0b77ff@mail.gmail.com>	 <456B1C52.4040305@s5r6.in-berlin.de>	 <e6babb600611270946o738327feqd7a18f2f1ff8fccd@mail.gmail.com>	 <456B2DD0.4060500@s5r6.in-berlin.de>	 <e6babb600611271234u5bb09ef1j1e26d68548770e88@mail.gmail.com>	 <456B680D.2000703@s5r6.in-berlin.de> <e6babb600611281107j2f03d5a7ld0214b2e82b305b8@mail.gmail.com>
In-Reply-To: <e6babb600611281107j2f03d5a7ld0214b2e82b305b8@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Crocombe wrote:
> On 11/27/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>> Posted writes are still enabled. phys_dma=0 disables only the physical
>> response unit.
...
> What I need is for write requests directed to
> address 0 to be directed to the asynchronous unit so that I can treat
> them as regular asynchronous write requests. 
...
> So long ways round, I think the phys_dma parameter is the proper thing
> for me.

Yes, correct.

(Leaving posted writes on has two subtle effects which may or may not be
interesting to you. 1. Write transactions will be performed as unified
transactions. 2. The transaction is already complete before the
controller writes to main memory. There are devices out there which
behave unexpectedly with unified transactions on, and some which do so
if they are off.)

> And I will try and do some actual thinking about what is happening.  I
> was hoping to offload that work to you and simply perform mechanical
> changes to the source!  Rats!

I'm on it, but working slowly, as usual. (I thought I get something
together during your holidays, but I fought with other buggy software
which crippled my main PC...)
-- 
Stefan Richter
-=====-=-==- =-== ===--
http://arcgraph.de/sr/
