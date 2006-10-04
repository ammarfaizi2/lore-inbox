Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbWJDSGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWJDSGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWJDSGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:06:44 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:6171 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1161546AbWJDSGm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:06:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: forcedeth net driver: reverse mac address after pxe boot
Date: Wed, 4 Oct 2006 11:06:30 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0189CAAEC@hqemmail02.nvidia.com>
In-Reply-To: <1159983049.25772.84.camel@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: forcedeth net driver: reverse mac address after pxe boot
Thread-Index: Acbn1z8hLyodPSYCRoiWOX1FLXVgKQACEBQg
From: "Ayaz Abdulla" <AAbdulla@nvidia.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Alex Owen" <r.alex.owen@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <c-d.hailfinger.kernel.2004@gmx.net>
X-OriginalArrivalTime: 04 Oct 2006 18:06:31.0304 (UTC) FILETIME=[D1F7D080:01C6E7DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a known issue and has been fixed in the latest PXE code. I will
have to find that information for you guys. Can one of you open a bug to
formally keep track of it.

Thanks,
Ayaz

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Wednesday, October 04, 2006 10:31 AM
To: Alex Owen
Cc: linux-kernel@vger.kernel.org; c-d.hailfinger.kernel.2004@gmx.net;
Ayaz Abdulla
Subject: Re: forcedeth net driver: reverse mac address after pxe boot


Ar Mer, 2006-10-04 am 17:19 +0100, ysgrifennodd Alex Owen:
> The obvious fix for this is to try and read the MAC address from the
> canonical location... ie where is the source of the address writen
> into the controlers registers at power on? But do we know where that
> may be?

Why not check if the first or last 3 bytes are the Nvidia owner bits.
The only card that will misdetect is 

00:16:17:17:16:00

which doesn't matter anyway

Alan

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
