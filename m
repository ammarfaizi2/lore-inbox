Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbTFSLxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 07:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265778AbTFSLxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 07:53:09 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:54676 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S265776AbTFSLxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 07:53:07 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Kimmo Sundqvist <rabbit80@mbnet.fi>
Date: Thu, 19 Jun 2003 14:06:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [2.5.72-mm1] Matroxfb behaves buggy
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <4DB2B104725@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jun 03 at 13:49, Kimmo Sundqvist wrote:
> I tried both MATROX_G450 and MATROX_G100 drivers, first G450 and then G100.  I 
> find it odd that both are configured, since selecting G450 hides G100 in 
> "make menuconfig", so I have all the time assumed it is disabled when it's 
> hidden.  Might the problem be caused by including both?  I'll go and see, but 
> I think it's not the only problem.
> 
> What's the difference between them?  .config help ought to tell this briefly.

As far as I can tell, it is as clear as it could be... First option
is named 'G100/G200/G400/G450/G550' support, while second is named
'G100/G200/G400'.

> When 2.4.20 switches to 1280x1024, the screen goes black with 2.5.72, then 
> some seconds pass and 1. vertical dark gray lines appear, and 2. some dark 
> blue areas between them.  Some seconds pass and X comes up as if nothing was 
> wrong.
> 
> I logged in to the console as root, not seeing anything.  The TFT display 
> reported 640x480@60Hz in it's menu.  I typed "fbset 1280x1024" for my custom 
> 1280x1024@60Hz mode.  Oddly, X display appeared at 1280x1024 resolution, mode 
> parameters being something between the fbset and X modes, but I could do 
> nothing, so I pushed the reset button.

fbset is not supported on 2.5.x kernels for setting console resolution.
If you want same environment you had in 2.4.x, get patch from
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest.
 
> syslog had a screenful of "^@^@^@^@^@^@^@^@^@^@^@" between time before the 
> lockup and next boot, as did kern.log

No surprise... But I doubt that it is matroxfb's problem.
                                                        Petr
                                                        

