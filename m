Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbRBCBPE>; Fri, 2 Feb 2001 20:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129048AbRBCBOz>; Fri, 2 Feb 2001 20:14:55 -0500
Received: from mail-dns1-nj.dialogic.com ([146.152.228.10]:14340 "EHLO
	mail-dns1-nj.dialogic.com") by vger.kernel.org with ESMTP
	id <S129036AbRBCBOp>; Fri, 2 Feb 2001 20:14:45 -0500
Message-ID: <EFC879D09684D211B9C20060972035B1D46850@exchange2ca.sv.dialogic.com>
From: "Miller, Brendan" <Brendan.Miller@Dialogic.com>
To: "'J . A . Magallon'" <jamagallon@able.es>,
        "Miller, Brendan" <Brendan.Miller@Dialogic.com>
Cc: "'linux-kernel @ vger . kernel . org'" <linux-kernel@vger.kernel.org>
Subject: RE: bidirectional named pipe?
Date: Fri, 2 Feb 2001 19:49:10 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought mkfifo was only unidirectional...

Brendan

Please cc: me personally, as I am not subscribed.

-----Original Message-----
From: J . A . Magallon [mailto:jamagallon@able.es]
Sent: Friday, February 02, 2001 4:47 PM
To: Miller, Brendan
Cc: 'linux-kernel @ vger . kernel . org'
Subject: Re: bidirectional named pipe?


Perhaps man 2 mkfifo ?

On 02.03 "Miller, Brendan" wrote:
> 
> I've countless web searches and linux-kernel archives, but I haven't yet
> found the answer to my question.
> 
> I'm porting some software to Linux that requires use of a bidirectional,
> named pipe.  The architecture is as follows:  A server creates a named
pipe
> in the /tmp directory.  Any client can then open("/tmp/pipename",
> O_RDWR|O_NDELAY) and gain access to the server.  The pipe is
bidirectional,
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
mailto:jamagallon@able.es                                          $> more
beer

Linux werewolf 2.4.1-ac1 #2 SMP Fri Feb 2 00:19:04 CET 2001 i686
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
