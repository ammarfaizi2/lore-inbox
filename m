Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129145AbQKXQuT>; Fri, 24 Nov 2000 11:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129257AbQKXQuK>; Fri, 24 Nov 2000 11:50:10 -0500
Received: from acl.lanl.gov ([128.165.147.1]:6709 "EHLO acl.lanl.gov")
        by vger.kernel.org with ESMTP id <S129145AbQKXQuA>;
        Fri, 24 Nov 2000 11:50:00 -0500
Date: Fri, 24 Nov 2000 09:19:58 -0700 (MST)
From: Ronald G Minnich <rminnich@lanl.gov>
To: I+D <jbertran@cirsa.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Booting AMD Elan520 without BIOS
In-Reply-To: <01C0562F.DAD0C2E0@wsi_joan.UNIDESA_RD>
Message-ID: <Pine.LNX.4.21.0011240917570.17415-100000@mini.acl.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, I+D wrote:

> I'm trying to boot an AMD Elan520 board without bios
> with kernel 2.4.0-test10 configured for i486 and PCI direct access.
> This kernel boots correctly from HD using the bios provided with the 
> evaluation board but kernel 2.4.0-test8 and previous hang
> after "Ok booting the kernel".

well, first I want your code for linuxbios :-)

> 	The last message I see is "Calibrating delay loop"
> (I see this thaks to the Jtag debugger for Elan520 because
> I haven't configured the VGA board yet).

you don't have clock interrupts on. If you are able to single step you'll
probably see it in the loop spinning on jiffies. This is one of our
regular problems with a new mainboard.

Also do you have serial console up? in many cases we have found that
having serial up eliminates about 50% of the things you do with a jtag
debugger.

ron

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
