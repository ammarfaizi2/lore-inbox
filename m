Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbTCDVSl>; Tue, 4 Mar 2003 16:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbTCDVSl>; Tue, 4 Mar 2003 16:18:41 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:44172 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261173AbTCDVSk>; Tue, 4 Mar 2003 16:18:40 -0500
Date: Tue, 4 Mar 2003 15:28:05 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.63] aha152x, module issues
In-Reply-To: <20030304204328.GA7271@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0303041527020.23375-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003, Sam Ravnborg wrote:

> On Mon, Mar 03, 2003 at 05:11:10PM -0500, Bill Davidsen wrote:
> > scripts/Makefile.modinst:16: *** Uh-oh, you have stale module entries. You messed with SUBDIRS, do not complain if something goes wrong.
> 
> This happens if you have encountered a compile error in a module.
> In this case you did not succeed the compilation of fs/binfmt_aout,
> and therefore no .o file can be located.
> kbuild assumes this is because you have messed with SUBDIRS, which is wrong.
> 
> Kai - the following patch fixes this for me.

Hmmh, interesting. The patch looks good to me, but there's still one thing 
I don't understand: When compiling a module errors out, we should never 
even go into the module postprocessing stage. Or were you running with -k?

--Kai


