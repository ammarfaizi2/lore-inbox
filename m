Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbSKCJlM>; Sun, 3 Nov 2002 04:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSKCJlL>; Sun, 3 Nov 2002 04:41:11 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:39830 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261750AbSKCJlK>;
	Sun, 3 Nov 2002 04:41:10 -0500
Date: Sun, 3 Nov 2002 10:47:05 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
In-Reply-To: <20021103030909.A11401@infradead.org>
Message-ID: <Pine.GSO.4.21.0211031045090.12527-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Christoph Hellwig wrote:
> On Sun, Nov 03, 2002 at 01:30:09AM +0000, Alan Cox wrote:
> > On Sun, 2002-11-03 at 00:06, J.A. Magallón wrote:
> > > As I see it, the onle thing that should be included in a standard kernel
> > > would be something like a kconfig-xaw, that is sure to be on every box that
> > > has X, and could be a reference implementation.
> > 
> > Lots of people no longer include Xaw either nowdays 8)
> > 
> > Probably the easiest way to do this would be to move the GUI tools out
> > of the kernel (or maybe leave the common useful ones) and have make
> > guiconfig do
> > 
> > 	if [ -f /usr/sbin/kernel-gui-config ] ; then
> > 		/usr/sbin/kernel-gui-config
> > 	elif got_qt() ; then
> > 		qt config
> > 	elif got_gtk() ; then
> > 		gtk_config
> > 	else
> > 		warnign message
> > 		make config
> > 	fi
> 
> Why does the kernel have to know about that tools at all?  Just put them
> into $PATH and let people just call $FOOCONFIG.  This works pretty well
> with mconfig on 2.2/2.4..

Just call it kguiconfig. Since /usr/bin/kguiconfig would be a symbolic link to
/etc/alternatives/kguiconfig on a Debian system, the sysadmin can choose which
of the zillion different available GUI kernel config programs you'll actually
run.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

