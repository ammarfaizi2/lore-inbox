Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313984AbSDKEdJ>; Thu, 11 Apr 2002 00:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313985AbSDKEdI>; Thu, 11 Apr 2002 00:33:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13006 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313984AbSDKEdH>; Thu, 11 Apr 2002 00:33:07 -0400
From: "Nivedita Singhvi" <nivedita@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: csum_and_copy_from_user, tcp_sendmsg and zero-copy question
To: melkorainur@yahoo.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF1387DD95.59CF98AE-ON88256B98.0016B176@boulder.ibm.com>
Date: Wed, 10 Apr 2002 21:33:28 -0700
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/10/2002 10:33:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think that a subset of zero-copy TCP has been
> implemented in the linux kernel as of the 2.4.4
> kernel (David Miller's patch). I say subset because
> examining the tcp_sendmsg code, I see tcp_copy_to_page
> which calls csum_and_copy_from_user which does a copy
> from user. Is my interpretation correct that the
> tcp_sendmsg codepath does zerocopy (for eth drivers
> that support the appropriate dev->feature) but does
> a single copy from user of the data buffer?

Thats correct (if I understand you correctly) - tcp_sendmsg()
code path does a copy from user to kernel. However, the sendfile()
code path does a zerocopy data transfer in the manner you are
thinking of (if I understand you correctly)...

(As of the 2.4.4 kernel).

thanks,
Nivedita


