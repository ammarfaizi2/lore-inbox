Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317322AbSFCJAa>; Mon, 3 Jun 2002 05:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317323AbSFCJA3>; Mon, 3 Jun 2002 05:00:29 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29704
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317322AbSFCJA2>; Mon, 3 Jun 2002 05:00:28 -0400
Date: Mon, 3 Jun 2002 01:59:14 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
In-Reply-To: <3CF9B4CC.7020205@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10206030142490.14596-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jun 2002, Martin Dalecki wrote:

> Of year 2010 - remember learning proper C will take him time.
> Becouse I never ever saw any code contributed by him
> despite the fact that I'm still open for patches, as
> I have told him upon request.
> Once exception was a broken patch which even didn't
> compile and couldn't solve the problem it was
> proclaiming to solve.

There is a difference.  I can pay a code monkey to write clean code.
Can you pay somebody to make the driver work?
Obviously you still can not read state diagrams even after I invited you
to IRC and walked you through the documents and explaining how there are
different events described in each.  I then explain the difference of how
there are two ways to enter each one.

Then you tell me you have a grand idea for a unified interrupt handler,
which guesses what the operation to be completed by reading the command
register.  But it is only command on a write, it is status on a read,
since an interrupt happened the command opcode is gone.  NICE.

Then you toss out the next one.  Gee, I can stall device interrupts to the
interface if a toggle the eIEN line on and off.  Now where you planning to
do this between DMA interrupts if you had more than one PRD?  I never
dreamed of such a brilliant idea, but you forgot one thing.  NO touching
the taskfile registers until you stop DMAing.  Either abort the
transaction of deadlock the interface.

Now I will go learn proper C, and you have all the time you need to try
get the data-transport layer right.

As for that patch I sent you, it works but you did not try.  See after I
sent it to you on a short test compile, I ran tests on it the next day.

Lastly, I started to make a new one, but since there is no way to
determine what the entry mode of the driver upon command block execution.

Regards ...

Andre Hedrick
LAD Storage Consulting Group

