Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbRBCE74>; Fri, 2 Feb 2001 23:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130001AbRBCE7q>; Fri, 2 Feb 2001 23:59:46 -0500
Received: from mail-dns2-nj.dialogic.com ([146.152.228.11]:30223 "EHLO
	mail-dns2-nj.dialogic.com") by vger.kernel.org with ESMTP
	id <S129481AbRBCE7l>; Fri, 2 Feb 2001 23:59:41 -0500
Message-ID: <EFC879D09684D211B9C20060972035B1D46853@exchange2ca.sv.dialogic.com>
From: "Miller, Brendan" <Brendan.Miller@Dialogic.com>
To: "Miller, Brendan" <Brendan.Miller@Dialogic.com>
Cc: "'linux-kernel @ vger . kernel . org'" <linux-kernel@vger.kernel.org>
Subject: RE: bidirectional named pipe?
Date: Fri, 2 Feb 2001 23:55:41 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Many thanks to all who have suggested to use UNIX domain sockets.  That was
my first thought--I just didn't know how to preserve the existing named
interface.  And yes, I have consulted several "decent" UNIX programming
books which have led me to the likelihood that what I want to do cannot be
done under Linux.  A shame, really, even if it is a travestible, abominable
way to do it.

The common, named pipe interface was a way to maintain compatibility with
legacy code of previous versions that are already out in the field.  If I
change the architecture now, folks porting from UnixWare to Linux (for
example) will have to change their applications (maybe--I haven't fully
analyzed whether I can change the underlying behavior without affecting our
API) in order to use Linux.

I am aware that the current design may not be the most efficient, or even
the most portable, but I was hoping to maintain it for compatibility sake.
If someone wants to tell me how to do it, great.  If not, I'll assume it
can't be done and start reworking everything to use socket() or
socketpair().

Thanks all,

Brendan

Please cc: me on all replies.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
