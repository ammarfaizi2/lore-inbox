Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbRGJSoG>; Tue, 10 Jul 2001 14:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbRGJSn4>; Tue, 10 Jul 2001 14:43:56 -0400
Received: from burdell.cc.gatech.edu ([130.207.3.207]:5894 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S267077AbRGJSnr>; Tue, 10 Jul 2001 14:43:47 -0400
Message-ID: <3B4B4CE0.BFC23F8F@cc.gatech.edu>
Date: Tue, 10 Jul 2001 14:43:44 -0400
From: Josh Fryman <fryman@cc.gatech.edu>
Reply-To: fryman@cc.gatech.edu
Organization: CoC, GaTech
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: ixp1200@cs.princeton.edu, linux-kernel@vger.kernel.org
Subject: questions on memory in linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

we've got some intel IXP 1200 (spin B0) eval boards, and are running 
linux in them.  we have some questions about how to do specific things
with (a) memory and (b) the cygmon mini-boot loader...

(a) memory:
        the IXP 1200 boards have 32M of SDRAM in two 16MB banks.  the
        bottom 24MB are used for linux, the rest are free... 
        however, we want to allocate some memory in that first bank
        and *tie* it down so that it's always available at that address
        physically to the IXP microengines as well as virtually to the
        linux system.  can anyone provide pointers to FAQs or other
        documents for handling this?  eg, some way to do a 
        malloc( 1MB ) and then get the true physical address of the 
        malloc results?  

(b) the IXP 1200 has a SA-1100 core running the cygmon mini loader from
        flash.  is there any way to specify kernel-load arguments,
        similar to how LILO works, with this system?  any pointers to
        where we can find out more details for this?  the process is to
        boot the cygmon from flash, give it the parameters for where to
        TFTP the kernel / ramdisk from, and then let it run.  we'd like
        to force the kernel to run with a "mem=4M" type of setting so
        it doesn't suck down our very meager memory for buffers we don't
        want/need.  (note, if we can do this, the part (a) above doesn't
	necessarily go away... it's something we still need to know how
	to do...)

thanks for any input,

josh
