Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267816AbRG3Uoh>; Mon, 30 Jul 2001 16:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267837AbRG3Uo1>; Mon, 30 Jul 2001 16:44:27 -0400
Received: from matrix2.enst.fr ([137.194.2.14]:41727 "HELO smtp2.enst.fr")
	by vger.kernel.org with SMTP id <S267816AbRG3UoR>;
	Mon, 30 Jul 2001 16:44:17 -0400
Date: Mon, 30 Jul 2001 22:43:28 +0200
From: Fabrice Gautier <gautier@email.enst.fr>
To: christophe =?ISO-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
Subject: Re: serial console and kernel 2.4
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010730165453.A19255@pc8.lineo.fr>
In-Reply-To: <20010730165453.A19255@pc8.lineo.fr>
Message-Id: <20010730223632.B82B.GAUTIER@email.enst.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.00.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Mon, 30 Jul 2001 16:54:53 +0200
christophe barbé <christophe.barbe@lineo.fr> wrote:

> I recently upgraded a linux box to the kernel 2.4.4 (from 2.2.18). This box
> has no display and use the serial console. Since the upgrade I can see the
> boot output on the remote console but I can't use the keyboard. Each time I
> press a key, an interrupt is seen by the no-display machine but no char
> appears in the console. 
> Today I've upgraded an another box to 2.4.7 with a similar setup and I've
> the same problem.
> 
> Is there something that I'm missing ? (something new with the kernel 2.4
> that is required for a serial console that was not required with the 2.2 ?)

It's probably a bug in your init.

I had the same, my init is busybox init, but maybe the sysv init has/had
the same problem.

Init have to set (or unset i don't remenber exactly) the CREAD flag when
opening the console in order to receive the input. Before 2.42 (or is it
2.4.3 ?) it seems that the kernel was not taking this flag into account
for anything.

The proposed fix for the kernel is a workaround.

The bug has been fixed in busybox (around v0.50 or v0.51).
(The guy working on busybox for lineo should be able to tell you. )

regards,

-- 
Fabrice Gautier <gautier@email.enst.fr>

