Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131604AbQKJTfC>; Fri, 10 Nov 2000 14:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131591AbQKJTem>; Fri, 10 Nov 2000 14:34:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11648 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131536AbQKJTeg>; Fri, 10 Nov 2000 14:34:36 -0500
Date: Fri, 10 Nov 2000 14:34:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "William F. Maton" <wmaton@ryouko.dgim.crc.ca>
cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in  /var/spool/mqueue]
In-Reply-To: <Pine.GSO.3.96LJ1.1b7.1001110135209.27803A-100000@ryouko.dgim.crc.ca>
Message-ID: <Pine.LNX.3.95.1001110142537.5403A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, William F. Maton wrote:

> On Fri, 10 Nov 2000, Jeff V. Merkey wrote:
> 
> > 
> > The sendmail folks are claiming that the TCPIP stack in Linux is broken,
> > which is what they claim is causing problems on sendmail on Linux
> > platforms.  Before anyone says, "don't use that piece of shit sendmail,
> > use qmail instead", perhaps we should look at this problem and refute
> > these statements -- I think that sendmail is causing this problem.  The
> > version is sendmail 8.9.3
> 
> What about sendmail 8.11.1?  Is the problem there too?
> 

I am running sendmail-8.11-0.Beta3 on Linux 2.4.0-test9. I didn't
have any problem with it (except that the documentation sucks,
making it extremely difficult to configure). Once configured, it runs
fine. It also ran fine on Linux-2.2.17.

If something is staying in the mail-queue `mailq`, this means that
the daemon isn't running. It may have crashed. This can be caused
by somebody keeping some mailer entry in /etc/inetd.conf. Sendmail
has to run as a daemon with no other interference on port 25.
Check the configuration.


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
