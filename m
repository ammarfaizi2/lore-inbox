Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbTDVGgz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 02:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbTDVGgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 02:36:55 -0400
Received: from web40802.mail.yahoo.com ([66.218.78.179]:30888 "HELO
	web40802.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262659AbTDVGgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 02:36:54 -0400
Message-ID: <20030422064853.43409.qmail@web40802.mail.yahoo.com>
Date: Mon, 21 Apr 2003 23:48:53 -0700 (PDT)
From: gordon anderson <gordonski_anderson@yahoo.com>
Subject: Re: 2.5.68 build - modules_install - depmod probs - 815fb / zlib - help
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Mutt.LNX.4.44.0304221540520.3736-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yeah...i guess Im thinking this dependency should be found
by depmod.

Can build fine if I put directly in kernel, but depmod
doesnt find the exports in vgastate.ko nor in the zlib
.ko's

Im not familiar with how depmod works - does it grab
System.map + all exports of all modules then match em? 
If so its not picking them up - dunno why, exports are
there!

Anyway, 2.5.68 dies horribly after reading superblock, so
somewhat academic :(

thanks anyway.

g.


--- James Morris <jmorris@intercode.com.au> wrote:
> On Mon, 21 Apr 2003, gordon anderson wrote:
> 
> > 
> > Sorry if wrong forum!
> > 
> > Building 2.5.68 kernel with intel815 framebuffer
> support &
> > crypto options.
> > 
> > make modules_install gives -
> > 
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.5.68/kernel/crypto/deflate.ko
> > depmod:         zlib_inflateInit2_
> > depmod:         zlib_inflate
> > depmod:         zlib_inflate_workspacesize
> > depmod:         zlib_deflateInit2_
> > depmod:         zlib_deflate_workspacesize
> > depmod:         zlib_deflate
> > depmod:         zlib_inflateReset
> > depmod:         zlib_deflateReset
> 
> You need CONFIG_ZLIB_INFLATE and CONFIG_ZLIB_DEFLATE for
> crypto/deflate.c, 
> which is provided by the default Kconfig.
> 
> 
> - James
> -- 
> James Morris
> <jmorris@intercode.com.au>
> 


__________________________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo
http://search.yahoo.com
