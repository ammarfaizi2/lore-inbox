Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284197AbRLKXiq>; Tue, 11 Dec 2001 18:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284182AbRLKXig>; Tue, 11 Dec 2001 18:38:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59143 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284217AbRLKXiZ>; Tue, 11 Dec 2001 18:38:25 -0500
Subject: Re: Lockups with 2.4.14 and 2.4.16
To: johan@ekenberg.se (Johan Ekenberg)
Date: Tue, 11 Dec 2001 23:47:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000901c1829b$b38e1720$050010ac@FUTURE> from "Johan Ekenberg" at Dec 12, 2001 12:29:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Dwct-0007QB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - My not-so-professional guess is that the machine is locked up waiting for
> some disk i/o that never happens, either to swap or normal filesystem. But,
> I might be all wrong.

I agree 100% with your diagnostic. Its directly as if your /var/spool volume
hung and the mylex stopped responding on that channel. I take it there is
nothing in dmesg ?

Another thing to try is

touch /foo &
hit return
(should report it finished)
touch /var/spool/foo &
(if this never returns you know you /var/spool choked for some reason)
