Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129641AbQLOQlz>; Fri, 15 Dec 2000 11:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130232AbQLOQlh>; Fri, 15 Dec 2000 11:41:37 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:27912 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129423AbQLOQlZ>;
	Fri, 15 Dec 2000 11:41:25 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Dana Lacoste" <dana.lacoste@peregrine.com>
Date: Fri, 15 Dec 2000 17:09:57 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re:       [OT] Re: Linus's include file strategy redux
CC: <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <FBFCEB5345D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Dec 00 at 11:00, Dana Lacoste wrote:
> > Maybe you did not notice, but for months we have
> > /lib/modules/`uname -r`/build/include, which points to kernel headers,
> > and which should be used for compiling out-of-tree kernel modules
> > (i.e. latest vmware uses this).
> 
> What about the case where I'm compiling for a kernel that I'm
> not running (yet)?
> 
> lm_sensors, for example, told me yesterday when I compiled it
> that I was running 2.2.17, but it was compiling for 2.2.18
> (because I moved the symlink in /usr/src/linux to point to
> /usr/src/linux-2.2.18)
> 
> I personally wouldn't like some programs to do a `uname -r`
> check because it won't do what I want it to :)

You can list /lib/modules/*/build/include and present user with list
of possible kernels. You should check whether version.h contents
matches directory name, but it is just an additional check against 
users which compile all kernels in /usr/src/linux.

For lmsensors, you just have to compile kernel first, and lm_sensors
after that. But intervening reboot is not required as long as
configure does not use 'uname -r' (ok, I'm filling vmware bugreport
just now).
                            Best regards,
                                    Petr Vandrovec
                                    vandrove@vc.cvut.cz
                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
