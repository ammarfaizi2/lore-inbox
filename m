Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289537AbSAVXIe>; Tue, 22 Jan 2002 18:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289536AbSAVXIY>; Tue, 22 Jan 2002 18:08:24 -0500
Received: from CPE-203-51-24-110.nsw.bigpond.net.au ([203.51.24.110]:23800
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S289533AbSAVXIG>; Tue, 22 Jan 2002 18:08:06 -0500
Message-ID: <3C4DF0CE.27676D6D@eyal.emu.id.au>
Date: Wed, 23 Jan 2002 10:07:58 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre3-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre6 - unresolved symbols
In-Reply-To: <Pine.LNX.4.21.0201221602360.2059-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Well, I ended up including a wrong patch in pre5. Do not use it.
> 
> Here is pre6 to fix that mistake.
> 
> pre6:

FYI:

depmod: *** Unresolved symbols in
/lib/modules/2.4.18-pre6/kernel/drivers/net/acenic.o
depmod:         pci_unmap_addr_set
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-pre6/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode

And I still needed to manually add
	EXPORT_SYMBOL(waitfor_one_page);
in kernel/ksyms.c

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
