Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130081AbRBSWaW>; Mon, 19 Feb 2001 17:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130086AbRBSWaN>; Mon, 19 Feb 2001 17:30:13 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:18655 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130081AbRBSWaD>; Mon, 19 Feb 2001 17:30:03 -0500
Message-ID: <3A919D83.FCC2EF5B@sympatico.ca>
Date: Mon, 19 Feb 2001 17:26:11 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Jaswinder Singh <jaswinder.singh@3disystems.com>, peterw@dascom.com.au,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel executation from ROM
In-Reply-To: <XFMail.20010219124909.peterw@dascom.com.au> <01e701c09a2a$21e789a0$bba6b3d0@Toshiba> <3A914E57.9990EB7C@sympatico.ca> <m1snlazc39.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:

> No it forbids executing boot roms that way, by a standard pc bios.
> The system BIOS in a PC is normally on the ISA bus which is reached
> across via the PCI bus with a PCI->ISA bridge.

Son of a gun, I missed that... sure enough my PIIX4 docs beside me here
show a #BIOSCS pin on the southbridge... Can anybody clarify what
this restriction does and doesn't apply to ?  The MindShare PCI Arch.
book where I got that info from doesn't elaborate that much.

> The thing is slow it really doesn't matter, all you need to do is
> enable caching on that area of the physical address space.  You can't
> do this on the alpha currently but only because the alpha sucks that
> way.  You can on practically everything else.
>
> As for ROM being slow on x86 you can enable the MTRR to speed things

Don't MTRR's just do write combining?

>
> up.  Usually though ROMs are at least as expensive as RAM, so it is
> pointless.

