Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129356AbRBCCdB>; Fri, 2 Feb 2001 21:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129529AbRBCCcv>; Fri, 2 Feb 2001 21:32:51 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:785 "EHLO
	ani.animx.eu.org") by vger.kernel.org with ESMTP id <S129356AbRBCCck>;
	Fri, 2 Feb 2001 21:32:40 -0500
Date: Fri, 2 Feb 2001 21:41:28 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: "Miller, Brendan" <Brendan.Miller@Dialogic.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: bidirectional named pipe?
Message-ID: <20010202214128.C21497@animx.eu.org>
In-Reply-To: <EFC879D09684D211B9C20060972035B1D4684F@exchange2ca.sv.dialogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <EFC879D09684D211B9C20060972035B1D4684F@exchange2ca.sv.dialogic.com>; from Miller, Brendan on Fri, Feb 02, 2001 at 07:33:09PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

How about use a unix socket instead of a named pipe.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
