Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271616AbRH1QBn>; Tue, 28 Aug 2001 12:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271796AbRH1QBd>; Tue, 28 Aug 2001 12:01:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16656 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271616AbRH1QB1>; Tue, 28 Aug 2001 12:01:27 -0400
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: hps@intermeta.de
Date: Tue, 28 Aug 2001 17:05:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9mge9l$sb9$1@forge.intermeta.de> from "Henning P. Schmiedehausen" at Aug 28, 2001 03:44:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15blMM-0006Dv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >	min(host->scsi.SCp.this_residual, DMAC_BUFFER_SIZE / 2);
> 
> >this_residual is "int", and "DMAC_BUFFER_SIZE" is just a #define for
> >an integer constant. So the above is actually a signed comparison, and
> >I'll bet you that was not what the author intended.
> 
> And the mistake of the author was not to write "unsigned int this_residual".
> That's the bug. Not the min() function.

Or more likely the author knew that this_residual was going to be positive
in all cases anyway. Its just sloppy typing by the scsi layer.

The typing of min() is something I do agree with Linus about (for once 8)),
and making people think about them is a good idea. When DaveM proposed the
original his patches showed up a bug in the older ixj driver immediately.

Alan

