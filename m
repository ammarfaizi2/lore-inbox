Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135980AbREBVhC>; Wed, 2 May 2001 17:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135989AbREBVgm>; Wed, 2 May 2001 17:36:42 -0400
Received: from carbon.btinternet.com ([194.73.73.92]:17293 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S135980AbREBVgl>; Wed, 2 May 2001 17:36:41 -0400
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramie.leavitt@btinternet.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: [OT] Interrupting select.
Date: Wed, 2 May 2001 22:46:03 +0100
Message-ID: <JKEGJJAJPOLNIFPAEDHLAEJGCOAA.laramie.leavitt@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think that this is slightly off-topic, but I figure that
someone here knows the answer or where to point me to the
answer.  Please respond privately so the entire list is not
spamed by the response.

I am writing a threaded network daemon using a thread per
connection model (I know, it is not the most effective, but
I can extend it to use a thread per N connections in the future).
That thread waits on a socket using select, or possibly merely
doing a read.  Messages to be written are inserted into a queue
in shared memory.  I am looking for a way to send the thread a 
signal or event to cause the thread to abort the read or select
call when data is available.

I know that it would be possible to create a unix socket
and write a byte to that socket whenever data is available,
but there should be a simpler message or signal that I can 
send to the thread to accomplish the same thing.

Thanks,
Laramie
