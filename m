Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbRCBVaY>; Fri, 2 Mar 2001 16:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129509AbRCBVaO>; Fri, 2 Mar 2001 16:30:14 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:42637 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S129525AbRCBVaA> convert rfc822-to-8bit; Fri, 2 Mar 2001 16:30:00 -0500
Date: Fri, 2 Mar 2001 22:29:45 +0100 (CET)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Sébastien HINDERER <jrf3@wanadoo.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Escape sequences & console
In-Reply-To: <"3a9ea6fa3b646cc9@citronier.wanadoo.fr> (added by    citronier.wanadoo.fr)">
Message-Id: <Pine.LNX.4.31.0103022208050.30419-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Sébastien HINDERER wrote:

> According to linux/drivers/console.c, function setterm_commands, case 12,
> one can change the virtual console by sending an escape sequence to
> /dev/cnsole (what I want to do), hower, this is not documented in man
> pages.

>From the source of the chvt program:

    if (ioctl(fd,VT_ACTIVATE,num)) {
        perror("chvt: VT_ACTIVATE");
        exit(1);
    }
    if (ioctl(fd,VT_WAITACTIVE,num)) {
        perror("VT_WAITACTIVE");
        exit(1);
    }

Where fd is /dev/tty, /dev/tty0, /dev/console or std{in,out,err} (From the
source, I doubt this ioctl works on all of those).

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!
UP:  10:29pm  up 7 days,  3:40,  8 users,  load average: 3.67, 4.43, 4.69

