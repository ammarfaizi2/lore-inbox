Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281083AbRKYVna>; Sun, 25 Nov 2001 16:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281091AbRKYVnM>; Sun, 25 Nov 2001 16:43:12 -0500
Received: from rome.broadwing.net ([216.142.238.216]:33174 "EHLO
	rome.broadwing.net") by vger.kernel.org with ESMTP
	id <S281083AbRKYVnH>; Sun, 25 Nov 2001 16:43:07 -0500
Message-ID: <3C016992.8C564A96@ntr.net>
Date: Sun, 25 Nov 2001 16:58:42 -0500
From: "Marco C. Mason" <mason@ntr.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: umiguel@alunos.deis.isec.pt, linux-kernel@vger.kernel.org
Subject: Re: copy to user
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Henriques--

Before making my suggestion: Apologies to the list if this has already
been settled.  I'm trying to catch up on my LKML reading, and I'm only
up to Nov 20 so far...

Anyway:  Here's what I'd do, if I had to do such a apalling thing  8^)

Drop a function in your code something like:

_xyzzy:
    db 0x18, 0xfe    ; jr $

Then, when you detect the condition where you want to waste time, then
put the address of this function on top of the user stack (along with
whatever else in the stack frame is required) so that the code just sits
there burning CPU.  To clean it up, you'd simply restore the original
stack frame to the process.

It's hideous & gross, but if you need it.....

--marco


