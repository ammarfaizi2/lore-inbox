Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291381AbSBMFoK>; Wed, 13 Feb 2002 00:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291383AbSBMFn6>; Wed, 13 Feb 2002 00:43:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:538 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291381AbSBMFnr>;
	Wed, 13 Feb 2002 00:43:47 -0500
Message-ID: <00f701c1b451$7cb56d60$ffb4fea9@pukaki>
From: "Michael Kerrisk" <m.kerrisk@gmx.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <willy@linuxcare.com>, <sfr@canb.auug.org.au>
In-Reply-To: <20020213002115.GB22307@gwyn.tux.org>
Subject: QN: Usage and purpose of file leases (F_SETLEASE, F_GETLEASE)
Date: Wed, 13 Feb 2002 06:44:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I've had a look through various LK archives, and elsewhere, and read the
sources, and there seems to be no documentation to be found on Linux file
leases (as set by fcntl(fd, F_SETLEASE, lease-type)).

My question(s): what are file leases, what applications currently use them,
and what are they used for?

After reading the relevant sources and doing a done a bit of
experimentation, I can see that setting a lease can allow one process to
find out if another process opens or truncates a specified file, through the
generation of a SIGIO signal.  That picture is very sketchy (e.g., there is
some system for downgrading a write lease to a read lease after a certain
timeout interval, but I haven't nailed down the details), and probably
incomplete - can anyone fill it out, or point me to documentation on file
leases.

Ultimately, I'd like to add material on file leases to the fcntl() man page.

Cheers

Michael



