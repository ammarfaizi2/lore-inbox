Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbREVVH5>; Tue, 22 May 2001 17:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262827AbREVVHr>; Tue, 22 May 2001 17:07:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31748 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262826AbREVVHi>; Tue, 22 May 2001 17:07:38 -0400
Subject: Re: scheduling callbacks in user space triggered via kernel....
To: ashok.raj@intel.com (Raj, Ashok)
Date: Tue, 22 May 2001 22:05:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ("Linux-Kernel (E-mail)")
In-Reply-To: <9319DDF797C4D211AC4700A0C96B7C9404AC1F7D@orsmsx42.jf.intel.com> from "Raj, Ashok" at May 22, 2001 01:15:56 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152JKx-0002TG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a method to schedule user mode code from kernel agent?

You can wake user processes,send them signals etc but ingeneral its not
a good idea

> registers with the kernel mode agent with a function/parm to run, then when
> the callback is appropriate the kerenl agent triggers this callback to
> happen.

The unix model is much more that the app does

	while(1)
	{
		get_event(fd);
		switcH(event)
		{
				..
			...
		}
	}

> or a method to bind a function to a file handle, when there is Completed IO,
> the kernel would call the registered function with a parameter of the buffer
> submitted for IO.

The b_end_io callback can possibly be used, or Ben's asynchronosu callbacks,
but that deals with kernel level completion.

Alan

