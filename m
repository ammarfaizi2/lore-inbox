Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292027AbSB0REQ>; Wed, 27 Feb 2002 12:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292813AbSB0RDy>; Wed, 27 Feb 2002 12:03:54 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:54182 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292806AbSB0RDf>; Wed, 27 Feb 2002 12:03:35 -0500
From: "Nivedita Singhvi" <nivedita@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: What is TCPRenoRecoveryFail ?
To: bjorn.wesen@axis.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF07806F93.A3E97A6C-ON88256B6D.005BC658@boulder.ibm.com>
Date: Wed, 27 Feb 2002 09:03:27 -0800
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/27/2002 10:03:31 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a TCP connection that is sending bulk data from
> a Linux 2.4.17 machine to a client. At some point, one of
> the packets from the Linux machine is lost, so the client
> asks for a retransmit by acking the last received correct
> packet. Then the Linux machine just keeps filling the
> clients open window, ignoring that and subsequent
> retransmit requests, never retransmitting any data.

Windows and Linux dont agree on DSACK options in some
situations, leading to symptoms you describe sometimes..

You can try echoing 0 into /proc/sys/net/ipv4/tcp_dsack
and see if that avoids the stall (just to identify the problem,
this is not the real way to go..).

Stats and a trace would be useful..

> /BW

thanks,
Nivedita

