Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRCFVA5>; Tue, 6 Mar 2001 16:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129473AbRCFVAr>; Tue, 6 Mar 2001 16:00:47 -0500
Received: from www.topmail.de ([212.255.16.226]:48373 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S129468AbRCFVAe> convert rfc822-to-8bit;
	Tue, 6 Mar 2001 16:00:34 -0500
Message-ID: <01b201c0a680$7adb7000$de00a8c0@homeip.net>
From: "Thorsten Glaser Geuer" <eccesys@topmail.de>
To: "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>,
        <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>, <bug-bash@gnu.org>
In-Reply-To: <200103051914.NAA63254@tomcat.admin.navo.hpc.mil>
Subject: Re: binfmt_script and ^M
Date: Tue, 6 Mar 2001 20:54:16 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>
To: <kodis@mail630.gsfc.nasa.gov>; "Richard B. Johnson" <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>; <bug-bash@gnu.org>
Sent: Monday, 5. March 2001 19:14
Subject: Re: binfmt_script and ^M


> John Kodis <kodis@mail630.gsfc.nasa.gov>:
> > On Mon, Mar 05, 2001 at 08:40:22AM -0500, Richard B. Johnson wrote:
> > 
> > > Somebody must have missed the boat entirely. Unix does not, never
> > > has, and never will end a text line with '\r'.
> > 
> > Unix does not, never has, and never will end a text line with ' ' (a
> > space character) or with \t (a tab character).  Yet if I begin a shell
> > script with '#!/bin/sh ' or '#!/bin/sh\t', the training white space is
> > striped and /bin/sh gets exec'd.  Since \r has no special significance
> > to Unix, I'd expect it to be treated the same as any other whitespace
> > character -- it should be striped, and /bin/sh should get exec'd.
> 
> Actually it does have some significance - it causes a return, then the
> following text overwrites the current text. Granted, this is only used
> occasionally for generating bold/underline/... 
> 
> This is used in some formatters (troff) occasionally, though it tends to
> use backspace now.

Less supports it, but ^H is quite more oftenly used.
ISO_646.irv:1991 aka ISO-IR-6 aka US-ASCII-7 _also_ defines
it, and we're going to be not ASCII-compatible any longer if we
aren't going to support CRLF line endings.
I also oftenly have the other problem round: LF endings in files which
are to be viewed under DOS. I use a 15-year-old text editor from
Digital Research (yes, DOS 3.41) which still is fine under W** and
DOSEMU, it looks like jstar only that I miss find and replace.
IMHO those problems could be solved with programmes/kernels/libs
accepting LF as line ending and CRLF (and possibly CRCRLF ...)
as a synonyme for LF, but treat CR non-LF differently. I have seen
this behaviour quite often in the past and am using it for myself, too
(except for native assembly progs).

> \r is not considered whitespace, though it should be possible to define
> it that way. A line terminator is always \n.
ACK

> Another point, is that the "#!/bin/sh" can have options added: it can be
> "#!/bin/sh -vx" and the option -vx is passed to the shell. The space is
> not just "stripped". It is used as a parameter separator. As such, the
> "stripping" is only because the first parameter is separated from the
> command by whitespace.

That's why I suggest treating CRLF (and only CR only-LF) as LF.

-mirabilos


