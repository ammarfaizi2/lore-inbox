Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbRAJAeq>; Tue, 9 Jan 2001 19:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132446AbRAJAeg>; Tue, 9 Jan 2001 19:34:36 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:58070 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S132706AbRAJAdz>;
	Tue, 9 Jan 2001 19:33:55 -0500
Date: Wed, 10 Jan 2001 01:33:52 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101100033.BAA04606@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, solon@macaulay.demon.co.uk
Subject: Re: Ftape bug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Tony Sumner wrote:

>I have a problem with ftape. What happened was that I had a backup on
>QIC80 tape that I made from Red Hat 5.2 and I (foolishly?) installed
>SuSE 7.0. I then found I could not read the tape with the newer version
>of ftape. 
>...
>Kernel version: was 2.0.36, now 2.2.16
>
>ftape version: 3.04d
>...
>what went wrong: tob reported 'No input'. The log in /var/spool/messages
>            had a report from ftape to say that it was looking at a 
>            new cartridge. An extract from the log is below. It was not
>            a new cartridge -- I have been able to read it by reloading
>            kernel 2.0.36 and the corresponding version 2.08 of ftape. 

Right. I'm pretty sure ftape-3.04d (as included in current 2.2 and 2.4
kernels) doesn't maintain read-compatibility with ftape-2.08. (See
Documentation/ftape.txt "Changes", and drivers/char/ftape/RELEASE-NOTES
about "sftape" being gone.)

I think your best bet is to read the tape using your 2.0.36 kernel
with ftape 2.08, reboot into 2.2.16, format the tape (or get a new one),
and then dump the data again using ftape 3.04d. Oh, and DON'T use the
built-in compression support. It's gone in ftape 4 :-)

>I am not a subscriber to this mailing list so I was advised to ask
>you to Cc any reply to me at solon@macaulay.demon.co.uk

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
