Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269257AbRHTUqJ>; Mon, 20 Aug 2001 16:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269274AbRHTUqA>; Mon, 20 Aug 2001 16:46:00 -0400
Received: from [209.202.108.240] ([209.202.108.240]:41735 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S269257AbRHTUpu>; Mon, 20 Aug 2001 16:45:50 -0400
Date: Mon, 20 Aug 2001 16:45:52 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Fw: select(), EOF...
In-Reply-To: <006d01c129b8$1957f2c0$0414a8c0@10>
Message-ID: <Pine.LNX.4.33.0108201644440.11734-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Carlos Fernández Sanz wrote:

> (sorry if this is a dupe, I haven't seen it come from the list, so I'm
> resending as plain ASCII in case majordomo kills messages with strange
> stuff)
>
> Hi,
>
> I need to do something similar to tail -f.
> I was hoping that select() or poll() would block my process after reaching
> EOF but (as the man says) EOF doesn't cause read() to block so select() and
> poll() both say I can read. The result is (obviously) that my program waits
> actively and uses all the CPU.
> What's the right way of doing this? I assume the kernel provides facilities
> to find out if there is new data to read (other than EOF).
>
> Thanks.

tail -f just alternates between open() and close(), keeping in memory the
current byte offest into the file.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

