Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSGBG3H>; Tue, 2 Jul 2002 02:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSGBG3G>; Tue, 2 Jul 2002 02:29:06 -0400
Received: from web20502.mail.yahoo.com ([216.136.226.137]:56104 "HELO
	web20502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316637AbSGBG3F>; Tue, 2 Jul 2002 02:29:05 -0400
Message-ID: <20020702063133.20857.qmail@web20502.mail.yahoo.com>
Date: Tue, 2 Jul 2002 08:31:33 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
To: vda@port.imtp.ilyichevsk.odessa.ua, Bill Davidsen <davidsen@tmr.com>
Cc: Willy TARREAU <willy@w.ods.org>, willy@meta-x.org,
       linux-kernel@vger.kernel.org, Ronald.Wahl@informatik.tu-chemnitz.de
In-Reply-To: <200207020546.g625krT21284@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I see a potential problem here: if someone is
> running such kernel all the time, he can take huge
> performance penalty. 'Dunno why but on
> my box mailer does not run. It _crawls_'.
> Ordinary user may perceive it like 'Linux is slow'.
> What can be done to prevent this? Printk can go
> unnoticed in the log, as far as nothing actually
> breaks user won't look into the logs...

As I state in my former mail, I think it would be
good to at least implement statistics on the
number of traps for each instruction set, and
also be able to disable emulation, to check
whether a program correctly runs without
or not.

> 1.big red letters 'CMOV EMULATION' across the
screen? :-)
> 2.Scroll lock LED inverted each time CMOV is
triggered?
> 3.Printk at kernel init time:
> "Emergency rescue kernel with CMOV emulation: can
> be very slow, not for production use!" ?

perhaps not, but we could send an alert message on
the system console the first time an instruction is
emulated, with the program's name. But nothing more,
else we'll have to modify the task struct to include
counters, and I really don't want that.

> Of course (1) is a joke.

so (2) isn't ? and you talk about overhead of 3 IFs
:-)

Cheers,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
