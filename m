Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262433AbTCROjl>; Tue, 18 Mar 2003 09:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262436AbTCROjl>; Tue, 18 Mar 2003 09:39:41 -0500
Received: from express.corp.cubic.com ([149.63.71.200]:2717 "EHLO
	express.corp.cubic.com") by vger.kernel.org with ESMTP
	id <S262433AbTCROjj>; Tue, 18 Mar 2003 09:39:39 -0500
Message-ID: <Pine.WNT.4.44.0303180946120.1424-100000@GOLDENEAGLE.gameday2000>
From: "Sparks, Jamie" <JAMIE.SPARKS@cubic.com>
To: DervishD <raul@pleyades.net>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: select() stress
Date: Tue, 18 Mar 2003 06:49:31 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C2ED5B.ABCDE700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C2ED5B.ABCDE700
Content-Type: text/plain;
	charset="iso-8859-1"

This message uses a character set that is not supported by the Internet
Service.  To view the original message content,  open the attached message.
If the text doesn't display correctly, save the attachment to disk, and then
open it using a viewer that can display the original character set. 
<<message.txt>> 

------_=_NextPart_000_01C2ED5B.ABCDE700
Content-Type: text/plain;
	name="message.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="message.txt"

Received: from GOLDENEAGLE.gameday2000 (GOLDENEAGLE [149.63.50.78]) by =
CURLY.ds.cubic.com with SMTP (Microsoft Exchange Internet Mail Service =
Version 5.5.2653.13)
	id CTBWS181; Tue, 18 Mar 2003 06:35:50 -0800
Date: Tue, 18 Mar 2003 09:49:31 -0500 (Eastern Standard Time)
From: Jamie Sparks <jamie.sparks@cubic.com>
To: DervishD <raul@pleyades.net>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,=20
    Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: select() stress
In-Reply-To: <20030318144632.GB1438@DervishD>
Message-ID: =
<Pine.WNT.4.44.0303180946120.1424-100000@GOLDENEAGLE.gameday2000>
X-X-Sender: sparksj@curly.ds.cubic.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=3DX-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE


I cannot find a posix nor linux implementation of getdtablehi().

To get around it, I do the following:

int a =3D3D open("some_file_I_know_exists",O_RDWR);
close(a);

then use a as the 1st param to select().

perhaps it ought to be a+1?

Jamie

On Tue, 18 Mar 2003, DervishD wrote:

>       Hi Richard, again :)
>
>       In my last message I told you that getdtablesize() is not
>   reliable for closing all file descriptors, that its return value is
>   not necessarily related to the file descriptor index. Well, I =
forgot
>   to say that getdtablehi() effectively returns the index for the
>   largest file descriptor available to the process plus one, that is,
>   perfect for using with 'select()' and for closing all open files:
>
>       for(i=3D3D0; i<getdtablehi(); i++) close(i);
>
>       Is this implemented under Linux? I have a piece of software =
that
>   relies on the above (now it's written using getdtablesize(), which =
is
>   non-correct as you noted) for closing all file descriptors...
>
>       Thanks again for noting this, Richard :)
>
>       Ra=3DFAl N=3DFA=3DF1ez de Arenas Coronado
>
>   --
>   Linux Registered User 88736
>   http://www.pleyades.net & http://www.pleyades.net/~raulnac
>


------_=_NextPart_000_01C2ED5B.ABCDE700--
