Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285134AbSAAO0F>; Tue, 1 Jan 2002 09:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286272AbSAAOZz>; Tue, 1 Jan 2002 09:25:55 -0500
Received: from inreach-gw1.idiom.com ([209.209.13.26]:3339 "EHLO
	smile.idiom.com") by vger.kernel.org with ESMTP id <S285134AbSAAOZo>;
	Tue, 1 Jan 2002 09:25:44 -0500
Message-ID: <3C31C62F.FFF175A9@obviously.com>
Date: Tue, 01 Jan 2002 09:22:39 -0500
From: Bryce Nesbitt <bryce@obviously.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
CC: Lionel Bouton <Lionel.Bouton@free.fr>, Andries.Brouwer@cwi.nl
Subject: Re: Why would a valid DVD show zero files on Linux?
In-Reply-To: <E16LMQj-0008Hv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Understood.   However, why can't that combination "just work"?  Changing
> > ... every time I switch between sticking in a CD-ROM and DVD-ROM is not cool.
> > Certainly that "other operating system" does not make me do that.
> 
> man fstab
> man ln
> 
> Its not a hard problem to solve that one

My vision of Linux extends to people who don't have the ability, desire or
time to "man fstab" *.


> > Are there any cases where udf filesystems are present on cdrom's that should
> > be read as iso9660?  Someone mentioned it's a hard heuristic to figure out
> > which fake filename the empty iso9660 filesystem uses.  How about, instead,
> > pick the larger of the two filesystems if both are present.
> 
> Now you've made the behaviour effectively random which is even worse. On
> a standard DVD the two file systems are the same. Some copy protected CD's
> have a UDF file system on them that isnt interesting. Some DVD's have an
> ISO fs that isnt interesting.

Windows, somehow, detects the difference.  Whatever method used by Windows
will be the one tested by the makers of most DVD/CDROM's.

Right now the behavior is deterministic from the Kernel's point of view,
but random from the users point of view (e.g. "the last 5 DVD-ROM's I bought
just worked, this one does not work").  Can detection be automated?  How
does Windows do it?  Can Linux do it even better?


If the distinction is something that can be automated well, then what is
the argument against doing it?

			-Bryce


* I fit under "desire".  Once I learned that udf existed (it's not in 
"man fstab"), I knew what to do.  I'd rather not know or care :-)!
