Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131746AbQKJUhp>; Fri, 10 Nov 2000 15:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131733AbQKJUhf>; Fri, 10 Nov 2000 15:37:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:19328 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131712AbQKJUhV>; Fri, 10 Nov 2000 15:37:21 -0500
Date: Fri, 10 Nov 2000 15:36:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in  /var/spool/mqueue]
In-Reply-To: <3A0C5A41.16EEAE78@timpanogas.org>
Message-ID: <Pine.LNX.3.95.1001110153527.6291A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Jeff V. Merkey wrote:

> 
> 
> Andrea Arcangeli wrote:
> > 
> > On Fri, Nov 10, 2000 at 03:07:46PM -0500, Richard B. Johnson wrote:
> > > It isn't a TCP/IP stack problem. It may be a memory problem. Every time
> > > sendmail spawns a child to send the file data, it crashes.  That's
> > > why the file never gets sent!
> > 
> > Sure that could be the case. You should be able to verify the kernel kills the
> > task with `dmesg`.
> > 
> > However Jeff said the problem happens over 400K and a 500K attachment shouldn't
> > really run any machine out of memory, so maybe this wasn't his same problem?
> 
> I think it is.  So it looks like sendmail is bombing when it attempts to
> send large files. 
> 
> Jeff 
> 

Yes. I was finally able to send Jeff a very large file. I had
to get rid of all the other memory consumers on this system.

Once it had enough memory, it got sent.


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
