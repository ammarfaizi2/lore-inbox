Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129950AbQK0Qbo>; Mon, 27 Nov 2000 11:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131466AbQK0Qbe>; Mon, 27 Nov 2000 11:31:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
        chaos.analogic.com") by vger.kernel.org with ESMTP
        id <S129950AbQK0QbV>; Mon, 27 Nov 2000 11:31:21 -0500
Date: Mon, 27 Nov 2000 10:59:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kaustubh Phanse <ksphanse@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Error after make bzImage
In-Reply-To: <20001127154743.27705.qmail@web310.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1001127105744.686A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Kaustubh Phanse wrote:

> 
> Hello!
> 
>       I am trying to recompile my kernel after adding
> some patches... After making the changes, I first run
> make dep and then make clean...both run fine. However,
> after running make bzImage it gives me the following
> errors:
> 
> make[2]: *** [ksyms.o] Error 1
> make[2]: Leaving directory
> `/usr/src/linux-2.2.16/kernel'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory
> `/usr/src/linux-2.2.16/kernel'
> make: *** [_dir_kernel] Error 2                      
> 
> I was not able to figure out what may be causing this
> problem. Can some one please help me out with this
> one?

Try:
cd /usr/src/linux/whatever
cp .config ..   # Save your configuration
make distclean	# Get rid of all old junk
cp ../.config . # Restore
make oldconfig
make dep
make bzImage
make modules
...etc




Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
