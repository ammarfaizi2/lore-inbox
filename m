Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314486AbSESPxy>; Sun, 19 May 2002 11:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSESPxx>; Sun, 19 May 2002 11:53:53 -0400
Received: from mail6.svr.pol.co.uk ([195.92.193.212]:32080 "EHLO
	mail6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S314486AbSESPxw>; Sun, 19 May 2002 11:53:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Will Newton <will@misconception.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.18 and VIA USB
Date: Sun, 19 May 2002 16:56:19 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E179T0J-0002gQ-00.2002-05-19-16-53-53@mail6.svr.pol.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have seen several posts in the archives that mention the following error on 
VIA chipset (usually K7V Athlon boards):

hub.c: USB new device connect on bus1/2, assigned device number 7
usb.c: USB device not accepting new address=7 (error=-110)
hub.c: Cannot enable port 2 of hub 1, disabling port.
hub.c: Maybe the USB cable is bad?

If anyone could shed any light on this or recommend a test to find out more I 
would be very grateful. It may or may not be related to my other USB problem.

I am seeing this error on attempting a bulk transfer to a USB camera:

usbdevfs: USBDEVFS_BULK failed dev 8 ep 0x81 len 4096 ret -110

The thing that strikes me about this is that the endpoint in question is 
specified thus:

			Endpoint Address: 81
			Direction: in
			Attribute: 2
			Type: Bulk
			Max Packet Size: 64
			Interval:   0ms

Max packet size of 64 would seem to indicate that packets of too large a size 
are being sent to the endpoint. Is this a correct analysis?

Any help with either of these problems would be much appreciated. Please CC 
any replies. Thanks.
