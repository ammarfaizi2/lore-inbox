Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135818AbRD3TOq>; Mon, 30 Apr 2001 15:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135822AbRD3TOk>; Mon, 30 Apr 2001 15:14:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1411 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135818AbRD3TOb>; Mon, 30 Apr 2001 15:14:31 -0400
Date: Mon, 30 Apr 2001 15:14:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "David S. Miller" <davem@redhat.com>
cc: Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'Kenneth Johansson'" <ken@canit.se>,
        Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: RE: 2.4 and 2GB swap partition limit
In-Reply-To: <15085.47104.75880.572242@pizda.ninka.net>
Message-ID: <Pine.LNX.3.95.1010430151259.15968A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, David S. Miller wrote:

> 
> Richard B. Johnson writes:
>  > On Mon, 30 Apr 2001, Torrey Hoffman wrote:
>  > > In general, is there a safe way to replace executable files for
>  > > programs that might be running while their on-disk images are
>  > > replaced?
>  > 
>  > Yes. Perfectly safe:
>  > 
>  > mv /usr/bin/exeimage /usr/bin/exeimage.sav
>  > cp /wherever/exeimage /usr/bin/exeimage
>  > 
>  > 
>  > The executing task will continue to use the old image until it exits.
> 
> Even more effective is:
> 
> mv /wherever/exeimage /usr/bin/exeimage
> 
> The kernel keeps around the contents of the old file while
> the executing process still runs.
> 
> This is also basically how things like libc get installed.
> A single mv is not only preserves currently referenced contents,
> it is atomic.
> 
> Later,
> David S. Miller
> davem@redhat.com

Sure, but now you can't get back if the new software doesn't run.
This is why I recommended the two steps and cautioned about testing
the new stuff first.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


