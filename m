Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265112AbSJWSG3>; Wed, 23 Oct 2002 14:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSJWSG3>; Wed, 23 Oct 2002 14:06:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:10412 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265112AbSJWSG2>; Wed, 23 Oct 2002 14:06:28 -0400
Message-ID: <3DB6E56D.8D930A1D@us.ibm.com>
Date: Wed, 23 Oct 2002 11:07:41 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: bert hubert <ahu@ds9a.nl>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       "David S. Miller" <davem@rth.ninka.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] tuning linux for high network performance?
References: <Pine.LNX.3.95.1021023133435.14975B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> No. It's done over each word (short int) and the actual summation
> takes place during the address calculation of the next word. This
> gets you a checksum that is practically free.

Yep, sorry, word, not byte. My bad. The cost is in the fact 
that this whole process involves loading each word of the data
stream into a register. Which is why I also used to consider
the checksum cost as negligible. 

> A 400 MHz ix86 CPU will checksum/copy at 685 megabytes per second.
> It will copy at 1,549 megabytes per second. Those are megaBYTES!

But then why the difference in the checksum/copy and copy?
Are you saying the checksum is not costing you 864 megabytes
a second??

thanks,
Nivedita
