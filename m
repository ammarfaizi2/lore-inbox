Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318289AbSG3PgI>; Tue, 30 Jul 2002 11:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318298AbSG3PgI>; Tue, 30 Jul 2002 11:36:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22144 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318289AbSG3PgH> convert rfc822-to-8bit; Tue, 30 Jul 2002 11:36:07 -0400
Date: Tue, 30 Jul 2002 11:40:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: DervishD <raul@pleyades.net>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Clearing the terminal portably
In-Reply-To: <3D46AEEF.mail2H19I8Z8@viadomus.com>
Message-ID: <Pine.LNX.3.95.1020730113257.2144A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, DervishD wrote:

>     Hi all :))
> 
>     I want to clear a terminal more or less 'portably' but without
> using curses (that's forced). I must work at least for the TERM
> 'linux' and it would be great if it works on all linux platforms. The
> portability is intended *only* within different linux archs, not
> more.
> 
>     I currently write 'ESC c' to the terminal and it works (it is the
> reset code for a 'linux' TERM), but I wonder if there is a better way.
> 
>     Thanks a lot :)
>     Raúl

This will work with most all terminals that claim 'ANSI-something' in
their specs.

static const char cler_scr[]="\033[H\033[J";
void cls()
{
    (void)write(STDERR_FILENO, cler_scr, sizeof(cler_scr)-1);
}


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

