Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271902AbRIDH4D>; Tue, 4 Sep 2001 03:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271905AbRIDHzx>; Tue, 4 Sep 2001 03:55:53 -0400
Received: from matrix.fr.professo.net ([213.11.43.1]:13582 "EHLO
	fr.professo.net") by vger.kernel.org with ESMTP id <S271902AbRIDHzs>;
	Tue, 4 Sep 2001 03:55:48 -0400
Message-ID: <00d001c13517$0caa6ca0$c200a8c0@professo.lan>
From: "Ghozlane Toumi" <gtoumi@messel.emse.fr>
To: "Simon Hay" <simon@haywired.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3B93CF91.A6D59DA8@haywired.org>
Subject: Re: Multiple monitors
Date: Tue, 4 Sep 2001 09:56:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Simon Hay" Said:


> Apologies in advance if this is a question that's already been answered
> somewhere...  I'm looking for a way to install multiple (or rather, two)
> PCI/AGP cards in a machine and connect a monitor to each one, and use
> them both *in console mode* -


this already exist in the current kernels, as long as you use video boards
that can be initialised independently
from the bios .
the 1st head can be whatever you want, but the next heads have to be
carefully chosen (matrox boards comes to mind)

then disable software scrollback as there are issues with multihead .
(append="video:scrollback:0")

>  preferably with some nice way to say
> 'assign virtual console 2 to the first screen, and 5 to the second' -
> that way you could have one tailing log files, showing 'top', whatever.

this is "con2fb":

to assign 2nd Virtual console to 2nd head :
con2fb /dev/fb1 /dev/tty2

ghoz

