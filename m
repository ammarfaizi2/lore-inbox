Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRALGz1>; Fri, 12 Jan 2001 01:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRALGzS>; Fri, 12 Jan 2001 01:55:18 -0500
Received: from katarina.atri.curtin.edu.au ([134.7.130.73]:44187 "EHLO
	katarina.atri.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S129267AbRALGzJ>; Fri, 12 Jan 2001 01:55:09 -0500
Date: Fri, 12 Jan 2001 14:55:14 +0800 (WST)
From: Anders Johansson <ajh@atri.curtin.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Question regarding driver developement
Message-ID: <Pine.LNX.4.10.10101121427280.3589-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am very sorry for disturbing the kernel development with this question
which I suspect might be off topic. If I am totally off topic please tell
me where to find help in your flame mails.

I am developing a device driver (will be GPL) for a PCI board hosting two
Digital Signal Processors (DSPs). The software running on the DSPs needs
disk access (~10Mb/s). The board has DMA engines built in to it's PCI
bridges which are capable of bus mastering. The Software running on the
DSPs requires soft realtime response from the disk access.

What I want to do is to stream data directly to a file on the hard drive if
possible.

The only way I have found so far is to write have two FIFO buffers in the
driver (in and out) and use a daemon running in user space to manage the
disk access. 

This is quite inefficient however since it requires at least 5 memcopy
operations before the data reaches the hard drive. 

I could dedicate one complete SCSI bus for the disk I/O.

Is it possible to write to a file from within a device driver? 
If it is it would save 3 memcopy operations (if I am correct :). 
Is it advisable?

I am not subscribed to this list so please reply to me personally.

Thank you very much for your help.
Best Regards,
//Anders

______________________________________________________________________
Anders Johansson    Room 314,113  Australian Telecommunications .-_|\
Visiting Research Associate       Research Institute (ATRI)    /     \
telephone:  +61 8 9266 3268       Curtin Uni of Technology     P_.-._/
e-mail: ajh@atri.curtin.edu.au            Bentley WA, 6102.         o
______________________________________________________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
