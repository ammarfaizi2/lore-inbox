Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135738AbRD3TEo>; Mon, 30 Apr 2001 15:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135789AbRD3TEe>; Mon, 30 Apr 2001 15:04:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:65410 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135738AbRD3TEP>; Mon, 30 Apr 2001 15:04:15 -0400
Date: Mon, 30 Apr 2001 15:04:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Torrey Hoffman <torrey.hoffman@myrio.com>
cc: "'Kenneth Johansson'" <ken@canit.se>,
        Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: RE: 2.4 and 2GB swap partition limit
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B9F@mail0.myrio.com>
Message-ID: <Pine.LNX.3.95.1010430145555.15714A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Torrey Hoffman wrote:

> 
> In general, is there a safe way to replace executable files for
> programs that might be running while their on-disk images are
> replaced?
> 

Yes. Perfectly safe:

mv /usr/bin/exeimage /usr/bin/exeimage.sav
cp /wherever/exeimage /usr/bin/exeimage


The executing task will continue to use the old image until it exits.
New tasks will use the new image. You can even replace `mv` and `cp`
this way. It is best to test new programs first, though, so you
know that it's linked with a runtime library that you have on your
system.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


