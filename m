Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135598AbRDXNSH>; Tue, 24 Apr 2001 09:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135599AbRDXNR6>; Tue, 24 Apr 2001 09:17:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61568 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135598AbRDXNRm>; Tue, 24 Apr 2001 09:17:42 -0400
Date: Tue, 24 Apr 2001 09:13:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: imel96@trustix.co.id
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104241917540.16169-100000@tessy.trustix.co.id>
Message-ID: <Pine.LNX.3.95.1010424090323.12078B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001 imel96@trustix.co.id wrote:

> 
> On Tue, 24 Apr 2001, Alexander Viro wrote:
> > What, makes it hard to write viruses for it? Awww, poor skr1pt k1dd13z...
[SNIPPED..]
> 
> > > And would that "use" by any chance include access to network?  >
> 
> >
> > So let him log in as root, do everything as root and be cracked
> > like a bloody moron he is. Next?
> >
> 
> come on, it's hard for me as it's hard for you. not everybody
> expect a computer to be like people here thinks how a computer
> should be.
> 
> think about personal devices. something like the nokia communicator.
> a system security passwd is acceptable, but that's it. no those-
> device-user would like to know about user account, file ownership,
> etc. they just want to use it.
> 

[SNIPPED...]
You are on the wrong list. You don't modify the kernel to make
a "single-user" machine. You modify the password file in /etc/passwd.
Until you know, and completely understand this, you will be laughed at.

When an interactive process is started, /bin/login gets the new
process information from the /etc/passwd file just before it gets
overwritten (exec) by the shell shown in that same password file.

If you want your accounts to have root privs, you set the UID and
GID fields in the password file to 0 and 0 respectively. I would
not suggest that you connect your computer to a network if you
do this.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


