Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280697AbRKYPEP>; Sun, 25 Nov 2001 10:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277152AbRKYPEG>; Sun, 25 Nov 2001 10:04:06 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:60922 "HELO
	pobox.com") by vger.kernel.org with SMTP id <S280697AbRKYPDz>;
	Sun, 25 Nov 2001 10:03:55 -0500
Subject: Re: Journaling pointless with today's hard disks?
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Sun, 25 Nov 2001 07:04:33 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011125133020.C1811@emma1.emma.line.org> from "Matthias Andree" at Nov 25, 2001 01:30:20 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011125150433.CEAE889CAD@pobox.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Claiming DC loss to cause hard errors? Design fault.
>
> IBM would really better shed some real light on this issue, and if they
> spoiled their firmware (heck, there ARE firmware updates for OEM disks
> of the 75GXP series) or electronics, they'd better admit that so as to
> reinstore the trust people had before DTLA drives were sold.

"Power off during write operations may make an incomplete sector which
will report hard data error when read. The sector can be recovered by a
rewrite operation."

http://www-3.ibm.com/storage/hdd/tech/techlib.nsf/techdocs/85256AB8006A31E587256A77006E0E91/$file/D60gxp_sp21.pdf

Deskstar 60GXP specifications, section 6.0

The above quote and URL are IBM's official word, from their OEM
specification manual.  FWIW, I checked the OEM manual for the 73LZX as
well (not that that drive is available anywhere, but I wanted to see
what IBM did/is doing for that drive), and the corresponding section in
that manual mentions nothing about incomplete sectors causing hard
errors. I just checked the 36LZX OEM spec as well and that also omits
the same clause.

OTOH, A few hours ago I checked the specs for several TravelStars and they
mentioned this incomplete sector thing. So, I guess IBM's position on
this is that this failure mode is OK for IDE drives but not for SCSI.

Here's a starting point for finding the IBM manuals:
http://www-3.ibm.com/storage/hdd/tech/techlib.nsf/pages/main?OpenDocument

(Just for my curiosity, I checked for the microdrives too. The phrasing
is different there: "There is a possibility that power off during a
write operation might make a maximum of 1 sector of data unreadable.
This state can be recovered by a rewrite operation.")

-Barry K. Nathan <barryn@pobox.com>
