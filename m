Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268889AbUHUIA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268889AbUHUIA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268891AbUHUIA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:00:27 -0400
Received: from qfep04.superonline.com ([212.252.122.160]:31874 "EHLO
	qfep04.superonline.com") by vger.kernel.org with ESMTP
	id S268889AbUHUIAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:00:25 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Aidas Kasparas'" <a.kasparas@gmc.lt>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 11:00:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <4126FDD8.1090101@gmc.lt>
Thread-Index: AcSHUvuDga9nOXgHTSC5DikdJM3mLQACZmgg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S268889AbUHUIAZ/20040821080025Z+1903@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that the interface 192.168.1.1 does not allow any tranmission
to occur. An implementation error I think... We send packets to 192.168.1.1,
we get no reply, but when we send packets to 192.168.77.1 we get the replies
(that is where the abnormality begins). However; the replies are now sourced
from 192.168.1.1 instead. That is, the blasted code in the device calculates
the checksum using the wrong IP address which it thinks it is assigned to...

-----Original Message-----
From: Aidas Kasparas [mailto:a.kasparas@gmc.lt] 
Sent: Saturday, August 21, 2004 9:47 AM
To: Josan Kadett
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

But will these checksums be incorect if crazy box would communicate with 
address in 192.168.1.x only?

The whole idea was based on the fact, that if that box works well in 
192.168.1.x networkd, then let it think it works in the network it knows 
how to work!

Josan Kadett wrote:
> It is definetely impossible to use IPTables to handle packets with
incorrect
> checksums since NAT would drop the connection right away, otherwise I
would
> not have been asking this question here.
> 
> -----Original Message-----
> From: Aidas Kasparas [mailto:a.kasparas@gmc.lt] 
> Sent: Saturday, August 21, 2004 8:54 AM
> To: Josan Kadett
> Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
> 
> How about setting up a separate box which would listen on that 
> 192.168.77.1 address and MASQUERADE connections to your crazy box from 
> 192.168.1.x address? Maybe then you would no longer need to break things 
>   in kernel?
> 
> 
> 

-- 
Aidas Kasparas
IT administrator
GM Consult Group, UAB



