Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRB0SUr>; Tue, 27 Feb 2001 13:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRB0SUh>; Tue, 27 Feb 2001 13:20:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49679 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129733AbRB0SUW>; Tue, 27 Feb 2001 13:20:22 -0500
Subject: Re: Bug Report in pc_keyb
To: shakes@emorific.com (Russell C. Hay)
Date: Tue, 27 Feb 2001 18:23:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14XoU0-0003ZY-00@emorific.com> from "Russell C. Hay" at Feb 27, 2001 06:04:20 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XomC-0003wo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in question.  I have linux 2.2.16 running fine on the box.  I am currently
> trying to upgrade to linux 2.4.2.  However, after compiling 2.4.2 and 
> installing in lilo and rebooting, I get the following error scrolling on
> my screen
> 
> "pc_keyb: controller jammed (0xFF)"
> 
> The box in question is a pentII with a supermicro motherboard.  I don't know
> the exact model number of the motherboard.  I think it is the p6sls board.
> I did some research on the error message, and apparently people have been
> getting this error on Alpha based systems too.  Does anyone know how to
> resolve this issue or if it is a known bug that is planning to be fixed
> or something along those lines?

There are a few cases in the pc keyboard controller not currently honouring
the delay protocol requirements (the keyboard controller was ancient when
the original PC came out) and some chipsets use keyboard controllers or
integrated keyboard support that still requires the delays. From checking
the ps2 mouse open code Im sure there are several others uncaught.

A second possibility is its USB stuff confusing things, build without USB or
with USB modular - I suspect the former

