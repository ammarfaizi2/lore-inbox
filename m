Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271278AbRH1PD3>; Tue, 28 Aug 2001 11:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271365AbRH1PDU>; Tue, 28 Aug 2001 11:03:20 -0400
Received: from urc1.cc.kuleuven.ac.be ([134.58.10.3]:14538 "EHLO
	urc1.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S271278AbRH1PDK>; Tue, 28 Aug 2001 11:03:10 -0400
Message-ID: <3B8BB2B9.302F6485@pandora.be>
Date: Tue, 28 Aug 2001 17:03:21 +0200
From: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
Organization: MyHome
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl-BE, nl, en, de
MIME-Version: 1.0
To: Camiel Vanderhoeven <camiel_toronto@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: DOS2linux
In-Reply-To: <001101c12fd0$0fd7f9c0$0100a8c0@kiosks.hospitaladmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Camiel Vanderhoeven wrote:
> 
> Did you do a normal read from memory, or did you use port-i/o?

I used the inb() function.

> you should use the latter. Of course, your card could be at 2000h in
> stead of 1000h, or at X000h for that matter.

My card is at 1000h, that's something i know for sure, because I can
probe the EISA ID at 0x1000+0xc80.

> I'm not very familiar with
> the EISA architecture, but I do know that each card can use the
> following I/O ranges:
> X000h-X0FFh; X400h-X4FFh; X800h-X8FFh; XC00-XCFF, where X is the slot
> number.

I guess you mean X0000h-X0FFF; X1000-X1FFF; ...

> There is a book on the EISA architecture available free of
> charge as a PDF file from www.mindshare.com/pdf/eisabook.pdf. Perhaps
> you'll find what you need to know from studying that. I hope this helps.

Tnx for the tip!  I will check it out!

I also found this URL: http://uw7doc.sco.com/cgi-bin/man/man?eisa+D4

It comes from UnixWare 7 documentation and there they have the kind of
translation that I want to do (that is: translate INT 15h call "Read
Function" (AH=D8h, AL=01h)) to linux.  As i understood there isn't
such thing available for linux?  Meaning I'll have to try and
implement that stuff myself?  But then the problem remains: how do i
get to the data that is in the 320 byte buffer returned from an INT
15h call "Read Function" (AH=D8h, AL=01h)
 

Greetzzz,
mc303

-- 
Ing. Bart Vandewoestyne			 Bart.Vandewoestyne@pandora.be
Hugo Verrieststraat 48			       GSM: +32 (0)478 397 697
B-8550 Zwevegem			 http://users.pandora.be/vandewoestyne
----------------------------------------------------------------------
"Any fool can know, the point is to understand." - Albert Einstein
