Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTJNVIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTJNVIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:08:40 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:34065 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S262771AbTJNVId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:08:33 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
Date: Tue, 14 Oct 2003 23:08:23 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed on 2.4.23-pre5 and pre7
In-Reply-To: <Pine.LNX.4.44.0310141152320.3275-100000@logos.cnet>
Message-ID: <Pine.OSF.4.51.0310142307150.471142@tao.natur.cuni.cz>
References: <Pine.LNX.4.44.0310141152320.3275-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, Marcelo Tosatti wrote:

>
>
> On Mon, 13 Oct 2003, [iso-8859-2] Martin MOKREJ? wrote:
>
> > Hi,
> >   it's a long time I haven't seen sthis messages, but it just happened that
> > I did on my laptop ASUS L3880C(1GB RAM). The message show on
> > 2.4.23-pre5+acpi20030918 and 2.4.23-pre7. The application get's killed on
> > 2.4.22-acpi20030918 too, just without the "0-order allocation" message.
> > I enabled in kernel the VM allocation debug option when configuring, but
> > apparently I have to turn it on also somewhere else. *Documentation* is
> > missing: 1) the help in "make config/menuconfig" etc. doesn't say anything,
> > the Documentation subdirectory doesn't say anything except "debug" as
> > kernel boot option on command-line(I did that too, but no change) and also
> > linux kernel-FAQ doesn't say either. :(
> >
> > How I tested?
> > `gzip -dc file | less' and pressed `G' to jump to the very end of the file.
> > The filesize is 280MB only. In a while, the mouse stopps moving for a
> > while, than the system gets sometimes unloaded, fan is raises it's RPM's up
> > and down town to time, and mouse cursor eventually does a move and then
> > less command gets killed. In dmesg I found:
> >
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > VM: killing process less
>
> Did you try to add some swap to the system?
>
> It seems you have none.

Yes, so far I did not need it. Do I really have to? I believe 1GB RAM
should suffice ... Sorry for not mentioning that!

-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
