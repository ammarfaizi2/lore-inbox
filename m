Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129512AbQKHIgB>; Wed, 8 Nov 2000 03:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129699AbQKHIfw>; Wed, 8 Nov 2000 03:35:52 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:31752 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129512AbQKHIfs>; Wed, 8 Nov 2000 03:35:48 -0500
Date: Wed, 8 Nov 2000 03:35:43 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ide-probe.c:400: `rtc_lock' undeclared and /lib/modules/..../build
In-Reply-To: <6444.973655982@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0011080333350.10929-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, Keith Owens wrote:

>Date: Wed, 08 Nov 2000 14:59:42 +1100
>From: Keith Owens <kaos@ocs.com.au>
>To: Mike A. Harris <mharris@opensourceadvocate.org>
>Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
>Content-Type: text/plain; charset=us-ascii
>Subject: Re: ide-probe.c:400: `rtc_lock' undeclared and
>    /lib/modules/..../build 
>
>On Tue, 7 Nov 2000 21:48:59 -0500 (EST), 
>"Mike A. Harris" <mharris@opensourceadvocate.org> wrote:
>>On Tue, 7 Nov 2000, Alan Cox wrote:
>>>Actually they do. I agree that it wants sorting. Im just wondering what the
>>>best approach is - maybe check modutils rev and only add the link if its high
>>>enough ?
>>
>>What if build-machine != machine-kernel-was-built-for?
>
>Then you are SOL, but that is a generic cross compile problem.  Anybody
>doing cross compile has to do extra steps to copy the results to the
>other machine and they can take care of problems like the build symlink
>themselves.  The patch in 2.2.18-pre20 fixes the problem for local
>compiles, which are 95%+ (SWAG) of the compiles.

I'm not refering to cross compiling.  I'm talking about if I
compile my kernel on machine A, and want to run this on 100%
hardware identical machine B.  What if machine B doesn't run the
same version of modutils?  In other words same hardware setup
different distribution or version of Linux?



----------------------------------------------------------------------
   NOTE:  My new email address is:  mharris@opensourceadvocate.org

      Mike A. Harris  -  Linux advocate  -  Open source advocate
              Computer Consultant - Capslock Consulting
                 Copyright 2000 all rights reserved
----------------------------------------------------------------------

#[Mike A. Harris bash tip #2 - custom colorized bash prompts]
# For a color prompt, put the following at the bottom of your ~/.bash_profile
TTYNAME=$(tty | sed -e 's/^\/dev\///' -e 's/^tty//');DRED=31;DGREEN=32
BROWN=33;DBLUE=34;DMAGENTA=35;DCYAN=36;GREY=37;DGREY=30\;1;RED=31\;1
GREEN=32\;1;YELLOW=33\;1;BLUE=34\;1;MAGENTA=35\;1;CYAN=36\;1;WHITE=37\;1
CLRUSER=$CYAN ; CLRHOST=$YELLOW   # Set the user and host colors here
PS1="$TTYNAME \[\033[${CLRUSER}m\]\u\[\033[0;m\]"
export PS1="${PS1}@\[\033[${CLRHOST}m\]\h\\[\033[0;m\]:\w\$ "

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
