Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270444AbRHHKSL>; Wed, 8 Aug 2001 06:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270445AbRHHKSB>; Wed, 8 Aug 2001 06:18:01 -0400
Received: from [216.6.80.34] ([216.6.80.34]:273 "EHLO dcmtechdom.dcmtech.co.in")
	by vger.kernel.org with ESMTP id <S270444AbRHHKRt>;
	Wed, 8 Aug 2001 06:17:49 -0400
Message-ID: <7FADCB99FC82D41199F9000629A85D1A01C650D2@dcmtechdom.dcmtech.co.in>
From: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
To: imran.badr@cavium.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: Exporting kernel memory to application
Date: Wed, 8 Aug 2001 15:48:50 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can do that by using kiobuf's ( only in kernel 2.4.x ).
That way you could lock the user buffers in kernel but you 
would have to allocate user buffer prior to using any kiobuf's functions 
like map_user_kiobuf() 

For example you could look at arch/cris/drivers/examples/kiobuftest.c

:),
Nitin


 -----Original Message-----
From: 	Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent:	Tuesday, August 07, 2001 4:31 PM
To:	imran.badr@cavium.com
Cc:	linux-kernel@vger.kernel.org
Subject:	Re: Exporting kernel memory to application

> I am in a situation where it is required to export a kernel memory
> (allocated by kmalloc in the device driver) to the user application. I
would
> really appreciate any guidance or suggestion.

Look at the sound drivers, they do this, although with memory allocated
by get_free_pages() - the rest of the theory is the same
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
