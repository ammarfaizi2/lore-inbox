Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131371AbQK0OgB>; Mon, 27 Nov 2000 09:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131120AbQK0Ofw>; Mon, 27 Nov 2000 09:35:52 -0500
Received: from nread2.inwind.it ([212.141.53.75]:15084 "EHLO relay4.inwind.it")
        by vger.kernel.org with ESMTP id <S131478AbQK0Ofr>;
        Mon, 27 Nov 2000 09:35:47 -0500
Date: Mon, 27 Nov 2000 15:05:43 +0100
From: Gianluca Anzolin <g.anzolin@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: Re: KERNEL BUG: console not working in linux
Message-ID: <20001127150543.A3083@dracula.home.intranet>
In-Reply-To: <20001126222828.A12137@dracula.home.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001126222828.A12137@dracula.home.intranet>; from root on Sun, Nov 26, 2000 at 10:28:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem solved

I had to bypass the following instructions in arch/i386/boot/setup.S

#
#       You must preserve the other bits here. Otherwise embarrasing
#       things
#       like laptops powering off on boot happen. Corrected version by
#       Kira
#       Brown from Linux 2.2
#
        inb     $0x92, %al                      #
        orb     $02, %al                        # "fast	A20" version
        outb    %al, $0x92			# some chips have only this

Then my system worked without problems.

Now what I ask is:
1) Why did they disable my videocard ?
2) Whate are they supposed to do?
3) Would you answer me this time ?

Many thanks to Rasmus, Albert & Jo Geraerts, the only three who answered
me. I would have expected more response from the list, but it seems the
old gold days are over

	Bye

	Gianluca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
