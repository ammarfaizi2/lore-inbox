Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131781AbRCOQcd>; Thu, 15 Mar 2001 11:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131779AbRCOQcN>; Thu, 15 Mar 2001 11:32:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21121 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131772AbRCOQcD>; Thu, 15 Mar 2001 11:32:03 -0500
Date: Thu, 15 Mar 2001 11:30:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Byron Stanoszek <gandalf@skylab.winds.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Need help with allocating a 2M buffer size
In-Reply-To: <Pine.LNX.4.31.0103151040280.2983-100000@skylab.winds.org>
Message-ID: <Pine.LNX.3.95.1010315112622.13697A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Byron Stanoszek wrote:

> I have a real picky tape drive (DLT series) that likes to be fed large chunks
> of data at once, otherwise after every 2-4KB of data it halts and rewinds
> itself because its cache for writing to the tape is empty.
> 
> My best solution to this problem was to use 'tar -b 4096', which sends 4096 x
> 512-byte blocks at once for a total of a 2MB buffer size. This worked fine for
> several weeks, until 2 days ago I got this message (and the backup fails):
> 
> st: failed to enlarge buffer to 2097152 bytes.
> 
Look at ../linux/drivers/scsi/st_options.h .
You might want to set ST_MAX_BUFFERS to a higher value. This wastes
some memory when the driver is not in-use, but you can reduce the
tendency to need to allocate more space at run-time.

You can also lower the ST_WRITE_THRESHOLD.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


