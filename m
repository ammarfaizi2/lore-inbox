Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTDGQ3b (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTDGQ3b (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:29:31 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:22919 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263523AbTDGQ33 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 12:29:29 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Vagn Scott <vagn@ranok.com>
Date: Mon, 7 Apr 2003 18:40:44 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [2.5.66-bk12] drivers/video/matrox/matroxfb_base.h:52:2
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <B11EBD0691@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Apr 03 at 11:39, Vagn Scott wrote:

> config is below
> Mon Apr  7 11:00:18 EDT 2003
> 2.5.66
> patch-2.5.66-bk12.bz2

ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-2.5.66-bk12.gz
(it is against latest bk, which may differ from bk12...)

Unfortunately generic portion is much larger than before, as new
logo code tries to look at info.fix and info.var before it calls
set_par() first time (at least after my other patches; I'll investigate
it further). And matroxfb does not contain anything valid
in info.fix before you call set_par()...

Change console size at runtime at your own risk (using fbset, not
stty), and remember that due to James's changes you have to use 
video=matroxfb:xxx instead of video=matrox:xxx... on kernel command line
(which pointed to me that it is time to get Grub as Debian's LILO 
is limited by 256 chars kernel cmdline :-( )
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz

