Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263917AbRFDWOr>; Mon, 4 Jun 2001 18:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263927AbRFDWOh>; Mon, 4 Jun 2001 18:14:37 -0400
Received: from user-vc8ftn3.biz.mindspring.com ([216.135.246.227]:37898 "EHLO
	mail.ivivity.com") by vger.kernel.org with ESMTP id <S263917AbRFDWOX>;
	Mon, 4 Jun 2001 18:14:23 -0400
Message-ID: <25369470B6F0D41194820002B328BDD20717B1@ATLOPS>
From: Bharath Madhavan <bharath_madhavan@ivivity.com>
To: linux-kernel@vger.kernel.org
Cc: Bharath Madhavan <bharath_madhavan@ivivity.com>
Subject: Question on Partial Checksum in TCP/IP
Date: Mon, 4 Jun 2001 18:14:16 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
	I am trying to understand a little bit about the TCP path in the
Linux kernel.
I saw that while we were even copying the user data into kernel space, we
were doing
the partial checksum of the data portion alone (as the TCP header is not yet
filled up) and storing 
it in skb->csum. 
Later on when we fill the header portion, we do the checksum of the header
and "add" it to the
already calculated checksum of the data. Here we check if the HW performs
the checksum 
or not (skb->ip_summed == CHECKSUM_HW). I am looking into kernel ver 2.4
My question is, why is this check not performed when the data is copied
initially. Instead of
calling csum_and_copy_from_user, if we did a memcpy in the case when HW does
the checksum,
would'nt that be more efficient? Or have I overlooked something...

Thanks a lot

PS. Please CC responses to me also as I am not subscribed to the mailing
list. Thanks

Bharath


