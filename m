Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274174AbRJVPNh>; Mon, 22 Oct 2001 11:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRJVPN2>; Mon, 22 Oct 2001 11:13:28 -0400
Received: from users.ccur.com ([208.248.32.211]:19651 "HELO amber2.ccur.com")
	by vger.kernel.org with SMTP id <S274174AbRJVPNM>;
	Mon, 22 Oct 2001 11:13:12 -0400
Date: Mon, 22 Oct 2001 15:13:40 GMT
Message-Id: <200110221513.PAA24852@amber2.ccur.com>
From: Tom Horsley <Tom.Horsley@mail.ccur.com>
To: linux-kernel@vger.kernel.org
Subject: Is this a clone() failing?
Reply-to: Tom.Horsley@mail.ccur.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the case of a debugger which also happens to be a multi-threaded
application. From what I understand, clone() is supposed to allow you to
inherit all attributes so the different threads can act like they are really
part of the same program, but it turns out that the thread which does the
ptrace "attach" is the only thread the kernel thinks should be allowed to do
any other operations on the process being debugged.

Should there be a new "clone debug privileges" flag?

Or is this just something (multi-threaded) debuggers have to live with?

(It wasn't too hard to force a single thread to always be the one that does
all ptrace() calls).
--
Tom.Horsley@mail.ccur.com                \\\\      Will no one rid me of
Concurrent Computers, Ft. Lauderdale, FL    \\\\     this troublesome
Me: http://home.att.net/~Tom.Horsley/          \\\\     autoconf?
Project Vote Smart: http://www.vote-smart.org     \\\\    !!!!!
