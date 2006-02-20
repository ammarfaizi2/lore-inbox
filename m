Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWBTKue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWBTKue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWBTKud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:50:33 -0500
Received: from canadatux.org ([81.169.162.242]:36765 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S964874AbWBTKuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:50:32 -0500
Date: Mon, 20 Feb 2006 11:50:16 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220105016.GA22552@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz> <20060220094300.GC19293@kobayashi-maru.wspse.de> <20060220103616.GC16042@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060220103616.GC16042@elf.ucw.cz>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Feb 20, 2006 at 11:36:16AM +0100, Pavel Machek wrote:
> On Po 20-02-06 10:43:00, Matthias Hensler wrote:
> > Linux has a whole crypto API in the kernel, so why is it a problem
> > to have LZF there too?
> 
> Because it is not needed there?

Hmmm, I think it makes totally sense there. While it is useful in the
suspend case, it would also be useful to the current implementation that
use the crypto API. Think about creating a compressed volume with
cryptoloop of dm-crypt.

> > About the progress bar: this is already implemented in userspace,
> > the kernel just forwards the progress via netlink to it. Not
> > necessarily ugly I think.
> 
> Look at the code.

OK, could you point me to the ugly thinks. I see message passing between
the userspace application and the kernel, for which I think that netlink
is a good choice.

What has to be done to make the code not ugly? Is there a way to fix it
to become acceptable?

Regards,
Matthias
