Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTDPQNn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTDPQNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:13:43 -0400
Received: from mcomail01.maxtor.com ([134.6.76.15]:19210 "EHLO
	mcomail01.maxtor.com") by vger.kernel.org with ESMTP
	id S264472AbTDPQNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:13:42 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D12A@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'hps@intermeta.de'" <hps@intermeta.de>, linux-kernel@vger.kernel.org
Subject: RE: [2.4.21-pre7-ac1] IDE Warning when booting
Date: Wed, 16 Apr 2003 10:25:18 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was thinking...

Do you know what attempted multi count was as an argument to SET MULTIPLE
MODE?

The specification says powers of 2 from 2 to 128 are all valid, however,
most drives I have looked at only support <= 16.  This has some sort of
historical oem reason for being the max and I haven't worked here long
enough to know the 'why'.

However, the ID block also reports the maximum multiple count in word 47
bits 7..0, so if that was non zero, the drive shouldn't abort it.

The engineer sitting next to me (former quantum employee) is reasonably
certain that the drive shouldn't be aborting that command.

It'd be interesting to look at the ID block and the task file for that
command that the drive aborted.

--eric

> > -----Original Message-----
> > From: Henning P. Schmiedehausen [mailto:hps@intermeta.de]
> > Sent: Wednesday, April 16, 2003 5:17 AM
> > To: linux-kernel@vger.kernel.org
> > Subject: Re: [2.4.21-pre7-ac1] IDE Warning when booting
> > 
> > Alan did post an explanation for these (which I haven't read before
> > posting this) that these are harmless. And yes, the 
> task_no_data_intr
> > vs. set_multmode makes all the difference. :-) Getting these quieted
> > down would be nice, though.
> > 
> > 	Regards
> > 		Henning
