Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSGCIOs>; Wed, 3 Jul 2002 04:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316973AbSGCIOr>; Wed, 3 Jul 2002 04:14:47 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:35303 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S316971AbSGCIOr> convert rfc822-to-8bit; Wed, 3 Jul 2002 04:14:47 -0400
Importance: Normal
Sensitivity: 
Subject: Re: hd_geometry question.
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFC6BCF5FE.976DF5FA-ONC1256BEB.002C62D4@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Wed, 3 Jul 2002 10:13:19 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/07/2002 10:17:06
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Just to make sure I got that right, HDIO_GETGEO delivers a FAKE geometry
>> based on the assumption that the sector size is 512 bytes ?
>
>I am tempted to just answer "yes".
>You capitalize FAKE, as if that is an interesting and important part.
>But non-fake geometries do not exist. Let me give a somewhat more
>explicit answer.

Thanks for the long answer, it helped me to understand the situation.
Our problem is that we do have a REAL geometry for the dasd disks on
a s/390. And for the old dasd driver in the 2.4 series HDIO_GETGEO
delivers the real geometry of the disk measured in physical blocks
which is not necessarily 512 bytes. Most often it is 4096 bytes.
The problem now is that if geo.start is REQUIRED to be measured in
512 byte blocks we have to incompatibly change the HDIO_GETGEO ioctl.
Not nice.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


