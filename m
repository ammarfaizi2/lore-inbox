Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130354AbRBCAsF>; Fri, 2 Feb 2001 19:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130481AbRBCArz>; Fri, 2 Feb 2001 19:47:55 -0500
Received: from jalon.able.es ([212.97.163.2]:54744 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130354AbRBCArU>;
	Fri, 2 Feb 2001 19:47:20 -0500
Date: Sat, 3 Feb 2001 01:47:11 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: "Miller, Brendan" <Brendan.Miller@Dialogic.com>
Cc: "'linux-kernel @ vger . kernel . org'" <linux-kernel@vger.kernel.org>
Subject: Re: bidirectional named pipe?
Message-ID: <20010203014711.A904@werewolf.able.es>
In-Reply-To: <EFC879D09684D211B9C20060972035B1D4684F@exchange2ca.sv.dialogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <EFC879D09684D211B9C20060972035B1D4684F@exchange2ca.sv.dialogic.com>; from Brendan.Miller@Dialogic.com on Sat, Feb 03, 2001 at 01:33:09 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps man 2 mkfifo ?

On 02.03 "Miller, Brendan" wrote:
> 
> I've countless web searches and linux-kernel archives, but I haven't yet
> found the answer to my question.
> 
> I'm porting some software to Linux that requires use of a bidirectional,
> named pipe.  The architecture is as follows:  A server creates a named pipe
> in the /tmp directory.  Any client can then open("/tmp/pipename",
> O_RDWR|O_NDELAY) and gain access to the server.  The pipe is bidirectional,
> so the client and server communicate on the same pipe.  I support a number
> of clients on the single pipe using file-locking to prohibit from two
> clients from writing/reading at once.
> 
> How can I do this under Linux?  In SVR4 Unices, I just use pipe() as it's
> pipes are bidirectional, and I can attach a name with fattach().  In SVR3
> Unices, I go through a bunch of hacking using the "stream clone device --
> /dev/spx".  I experiemented with socket-based pipes under Linux, but I
> couldn't gain access to them by open()ing the name.  Is there help?  I
> really don't want to use LiS (the Linux Streams) package, as I'd rather do
> something native and not be dependent on another module.  Plus, I read
> somewhere that this was a poor way to do things.
> 
> Brendan
> 
> Please cc: me personally, as I am not subscribed.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac1 #2 SMP Fri Feb 2 00:19:04 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
