Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277573AbRJLITX>; Fri, 12 Oct 2001 04:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277576AbRJLITO>; Fri, 12 Oct 2001 04:19:14 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:1807 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S277573AbRJLITB>; Fri, 12 Oct 2001 04:19:01 -0400
Message-ID: <3BC6A841.34AEB2BC@loewe-komp.de>
Date: Fri, 12 Oct 2001 10:22:25 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: so, no way to kill process? have to reboot?
In-Reply-To: <3BC6097F.79B6E2D1@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen wrote:
> 
> Well, the unkillable process continues on.  Does nobody else have any ideas on
> how to kill an unkillable process in the R state thats sucking up all my unused
> cpu cycles?
> 
> If not I'm going to have to reboot this thing...
> 

Well, I'd suspect it in "D" state - waiting for some disk I/O to
finish...

But in "R" with your described behavior looks like a bug.
If you care about the CPU time waisted: what about kill -STOP <pid>?

Can you describe your filesystem layout?
I think of a symlink recursion bug or something wrong in /dev/shm
or alike... (no flame, just guessing :)

What are the parameters of "find"?
