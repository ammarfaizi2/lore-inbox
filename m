Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271124AbRH1OpR>; Tue, 28 Aug 2001 10:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271142AbRH1OpH>; Tue, 28 Aug 2001 10:45:07 -0400
Received: from oe50.law9.hotmail.com ([64.4.8.22]:6927 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S271124AbRH1Oox>;
	Tue, 28 Aug 2001 10:44:53 -0400
X-Originating-IP: [65.92.114.22]
From: "Camiel Vanderhoeven" <camiel_toronto@hotmail.com>
To: "'Bart Vandewoestyne'" <Bart.Vandewoestyne@pandora.be>,
        <linux-kernel@vger.kernel.org>
Subject: RE: DOS2linux
Date: Tue, 28 Aug 2001 10:45:20 -0400
Message-ID: <001101c12fd0$0fd7f9c0$0100a8c0@kiosks.hospitaladmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <3B8B4027.5DE84CE9@pandora.be>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2526.0000
Importance: Normal
X-OriginalArrivalTime: 28 Aug 2001 14:45:05.0796 (UTC) FILETIME=[06DD6440:01C12FD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Vandewoestyne wrote:
>
> I tried reading bytes from the following locations:
> 
> 0x1000+0xb2		-> gives me 255
> 0x1000+0xc80+0xb2	-> gives me 255
> 0x1000+0xc84+0xb2	-> gives me 255
> 
> same for 0xc0
> 
> I guess these aren't the values I should be expecting... :-(

Did you do a normal read from memory, or did you use port-i/o? I think
you should use the latter. Of course, your card could be at 2000h in
stead of 1000h, or at X000h for that matter. I'm not very familiar with
the EISA architecture, but I do know that each card can use the
following I/O ranges:
X000h-X0FFh; X400h-X4FFh; X800h-X8FFh; XC00-XCFF, where X is the slot
number. There is a book on the EISA architecture available free of
charge as a PDF file from www.mindshare.com/pdf/eisabook.pdf. Perhaps
you'll find what you need to know from studying that. I hope this helps.

Veel success ermee,

Camiel.

