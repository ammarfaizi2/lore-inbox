Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288175AbSACDjl>; Wed, 2 Jan 2002 22:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288173AbSACDjc>; Wed, 2 Jan 2002 22:39:32 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:50644 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S288169AbSACDjS>; Wed, 2 Jan 2002 22:39:18 -0500
Message-ID: <3C33D152.79FC8251@didntduck.org>
Date: Wed, 02 Jan 2002 22:34:42 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102211038.C21788@thyrsus.com> <Pine.LNX.4.33.0201030327501.5131-100000@Appserv.suse.de> <20020102220333.A26713@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Dave Jones <davej@suse.de>:
> > See other posting with examples of dramatic failures of
> > 'slots in box, but dmi says none' and 'no slots, dmi says some'.
> > still think this is usable ? You're nuts.
> 
> One of my background assumptions is that the older a machine is, the
> more likely it is that the person doing the config will have a clue about
> what they're doing.   These days hardware is so cheap that only geeks try
> to cram Linux onto old systems -- and even the geeks mostly do it just to
> prove they can.
> 
> Thus I'm not very worried about DMI read failing on older hardware.
> My main objective is to make configuration painless on modern PCI-only
> hardware -- which is why I want to be able to tell when there are no
> ISA slots, so I can deep-six questions about ISA drivers.

Then the best thing to do is to put a disclaimer on your
autoconfiguration program: "WARNING: autoconfigure may not detect older
hardware that was not designed for reliable detection.  If autoconfigure
fails to detect all of your hardware, you may need to manually configure
your kernel."

Sometimes perfection isn't worth the effort, especially when trying to
support a class of hardware that is rapidly becoming obsolete.  Optimize
for the most likely case, and deal with the rare corner cases with other
means.

-- 

						Brian Gerst
