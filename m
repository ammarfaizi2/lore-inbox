Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbRBLQ7s>; Mon, 12 Feb 2001 11:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129344AbRBLQ7i>; Mon, 12 Feb 2001 11:59:38 -0500
Received: from cicero2.cybercity.dk ([212.242.40.53]:37894 "HELO
	cicero2.cybercity.dk") by vger.kernel.org with SMTP
	id <S129449AbRBLQ73>; Mon, 12 Feb 2001 11:59:29 -0500
Message-ID: <004501c09516$ddf03520$23f9423e@avenger>
From: "Henrik Stokseth" <hstokset@privat.cybercity.no>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010212164358.2762.qmail@web119.yahoomail.com>
Subject: Re: Programmatically probe video chipset
Date: Mon, 12 Feb 2001 18:11:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Powell <moloch16@yahoo.com> wrote:

> Is there an API or other means to determine what video
> card, namely the chipset, that the user has installed
> on his machine?

for PCI and AGP cards you can scan through the bus and fetch all
vendor:device numbers of type 7 (vga compatible) IIRC and then match them
against a database. i have the code for this if you're interested.
for ISA cards that has PnP functionality you can get the vendor string using
a PnP interrupt service routine, I have never actually done that but i know
that it is possible.
But for most cards you can use the VESA VBE API to fetch the information,
you will have to do this from real/virtual mode afaik.
If you're not interrested in programming hardware you can use the pci
interface in /proc instead which is the best solution if you're running
linux. ;o)

-henrik


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
