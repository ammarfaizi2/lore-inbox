Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283320AbRK2Qxu>; Thu, 29 Nov 2001 11:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283327AbRK2Qxl>; Thu, 29 Nov 2001 11:53:41 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:9482 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S283322AbRK2Qxd>;
	Thu, 29 Nov 2001 11:53:33 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Petr Titera <P.Titera@century.cz>
Date: Thu, 29 Nov 2001 17:52:49 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Patch] Windows CP1250 support
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <A936D1616A6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 01 at 17:06, Petr Titera wrote:
> 
> Linux contains two codepages for Central European languages (CP852 and
> iso8859-2) but neither one is correct for character encoding used in 
> Central European version of Windows (which uses Microsoft's CP1250). 
> This patch adds support for this codepage.

> +  If you want to display filenames with native language characters
> +  from the Microsoft FAT file system family or from JOLIET CDROMs
> +  correctly on the screen, you need to include the appropriate

Correct me, if I'm wrong, but FAT (MSDOS, VFAT short name) uses
CP852, and VFAT long name uses unicode. JOLIET also uses unicode.
CP1250 is not used anywhere near to filesystems in Microsoft Windows,
even Microsoft was bright enough to use only one (MSDOS compatible)
encoding (+ unicode) on externally visible filenames.

And your system itself (userspace) should use ISO-8859-2, so I see
no need for CP1250 - everything works fine here without it. Maybe you
are creating your CDROMs with 16bit-encoded CP1250 instead of unicode,
but then you should replace your CDROM creating software.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
