Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270014AbTGLKfi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 06:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270015AbTGLKfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 06:35:38 -0400
Received: from CPE-203-51-27-111.nsw.bigpond.net.au ([203.51.27.111]:25852
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S270014AbTGLKfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 06:35:31 -0400
Message-ID: <3F0FE7E5.B3696C9A@eyal.emu.id.au>
Date: Sat, 12 Jul 2003 20:50:13 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre5 - unresolved in hfsplus
References: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva> <3F0F6B86.46FF4A6A@eyal.emu.id.au> <20030712082915.GA2409@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" wrote:
> 
> On 07.12, Eyal Lebedinsky wrote:
> > Marcelo Tosatti wrote:
> > > Here goes -pre5.
> > > J. A. Magallon:
> > >   o hfsplus: group Apple FS's and help text
> >
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.22-pre5/kernel/fs/hfsplus/hfsplus.o
> > depmod:         mark_page_accessed
> >
> 
> I did not touch the code, I suppose nobody has tried to build it as a module.

Something was touched since I did not have this problem with the
2.4.21-ac
series which included hfsplus. This problem arrived with 2.4.22-pre3
(when hfsplus was introduced) so there was some merge issue maybe?

Actually, diffing .22-pre3-ac1 and .22-pre3 shows a few more fixes with
operator precedence missing in -pre3, like

-       if (!file->f_flags & O_DIRECT)
+       if (!(file->f_flags & O_DIRECT))

Which I am sure must be fixed.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
