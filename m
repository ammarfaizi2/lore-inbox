Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293589AbSBZMEA>; Tue, 26 Feb 2002 07:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293590AbSBZMDu>; Tue, 26 Feb 2002 07:03:50 -0500
Received: from mtao3.east.cox.net ([68.1.17.242]:1248 "EHLO lakemtao03.cox.net")
	by vger.kernel.org with ESMTP id <S293589AbSBZMDd>;
	Tue, 26 Feb 2002 07:03:33 -0500
Message-ID: <009201c1bebd$7a5f5910$a7eb0544@CX535256D>
From: "Barubary" <barubary@cox.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E16fgL7-0000R4-00@the-village.bc.nu>
Subject: Re: ISO9660 bug and loopback driver bug
Date: Tue, 26 Feb 2002 04:02:34 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thats actually locale dependant, but yes. I'll fix that one.

Why is it locale-dependent?  All ISO9660 file times are stored as Gregorian
calendar dates regardless of who made them, and the target (UNIX file time)
isn't locale-dependent either.  Why would it affect the calculation if the
local system used the Muslim calendar?

You're probably right, but I just want to know why so I'll know for the
future.

Shouldn't there be a gregorian_date_to_unix_time() function in the kernel so
that every driver that needs such conversion can share that implementation?
It would keep date processing consistent and make it easy to spot date bugs.

-- Barubary

