Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292806AbSB0RUB>; Wed, 27 Feb 2002 12:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292836AbSB0RTk>; Wed, 27 Feb 2002 12:19:40 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:54668 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292818AbSB0RSH>; Wed, 27 Feb 2002 12:18:07 -0500
From: "Nivedita Singhvi" <nivedita@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: How to disable TCP's checksum
To: zhuyingj@comp.nus.edu.sg
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF52308070.845FF676-ON88256B6D.005DD163@boulder.ibm.com>
Date: Wed, 27 Feb 2002 09:17:56 -0800
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/27/2002 10:18:01 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I am currently using kernel version 2.4.2 and trying to
> disable tcp_input's checksum function. However, even
> I comment all the csum_error in the file tcp_input.c, the
> packet (with wrong checksum) seems still will be dropped.

If the checksum field is the only one thats incorrect or messed
up, then disabling the checksum will suffice.  But if any other part
of the packet is also corrupted or altered in some way, it
might fail the many other checks both IP and TCP perform.

(Sorry, I know thats fairly obvious, but its easy to miss a check
or two. :) )

> Zhu Ying jie

thanks,
Nivedita

