Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129731AbQKGPqp>; Tue, 7 Nov 2000 10:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129767AbQKGPqe>; Tue, 7 Nov 2000 10:46:34 -0500
Received: from ppp-96-111-an01u-dada6.iunet.it ([151.35.96.111]:17926 "HELO
	home.bogus") by vger.kernel.org with SMTP id <S129731AbQKGPqT>;
	Tue, 7 Nov 2000 10:46:19 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: A question about memory fragmentation
Date: Tue, 7 Nov 2000 17:58:26 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <CAEBJLAGJIDLDINHENLOGEMOCGAA.abel@trymedia.com> <20001107163325.F20883@arthur.ubicom.tudelft.nl>
In-Reply-To: <20001107163325.F20883@arthur.ubicom.tudelft.nl>
MIME-Version: 1.0
Message-Id: <00110718025900.00535@linux1.home.bogus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2000, Erik Mouw wrote:
> 
> > 	Is the kernel memory fragmentation a solved problem in Linux? (I wish it).
> 
> My guess is that the slab allocator solves this, but I don't know that
> much about the MM.

Linux lists implementation stores linking informations directly inside the
block of data We're going to link.
This has the advantage that no extra list nodes are allocated to store the data
pointer but has the drawback that if We've to link the same data to more than
one list We've to declare more than one listhead.
See at the different links We've inside the task_struct for example.



- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
