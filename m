Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUGLUVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUGLUVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUGLUVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:21:25 -0400
Received: from screech.rychter.com ([212.87.11.114]:7821 "EHLO
	screech.rychter.com") by vger.kernel.org with ESMTP id S262380AbUGLUVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:21:07 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.26: kernel BUG at page_alloc.c:235\
References: <m23c3wzacq.fsf@tnuctip.rychter.com>
	<20040712183819.GA5059@logos.cnet>
X-Spammers-Please: blackholeme@rychter.com
From: Jan Rychter <jan@rychter.com>
Date: Tue, 13 Jul 2004 01:19:10 -0700
In-Reply-To: <20040712183819.GA5059@logos.cnet> (Marcelo Tosatti's message
 of "Mon, 12 Jul 2004 15:38:19 -0300")
Message-ID: <m2u0wcxqtd.fsf@tnuctip.rychter.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Marcelo" == Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
 Marcelo> On Mon, Jul 12, 2004 at 11:31:49PM -0700, Jan Rychter wrote:
 >> Linux 2.4.26 compiled with gcc-2.96 20000731 (RH7.1 2.96-85),
 >> running on an Athlon XP2200+ clocked at 1800MHz.
 >>
 >> Any ideas?

 Marcelo> Hi Jan,

 Marcelo> The BUG() is at rmqueue(), "if (PageLRU(page)) BUG".

 Marcelo> The same BUG has been seen before. The BUG means an LRU page
 Marcelo> was found in a zone's free list (this is not a valid thing to
 Marcelo> happen).

 Marcelo> This could be either a driver bug (which uses a page after
 Marcelo> freeing it, as wli smartly pointed out at the time) or faulty
 Marcelo> hardware, as it showed to be in that occasion.

 Marcelo> What drivers are you using 

8139too for networking, reiserfs and ext2 for filesystems. Not much
more, really. IDE drives. iptable_nat + ip_conntrack. TUN/TAP. That's
pretty much it.

 Marcelo> and, just as matter of "safety", have you ran memtest on this
 Marcelo> box?

Unfortunately, no -- and it isn't all that easy for me to do so (the box
is remotely hosted). I will try to do it...

--J.
