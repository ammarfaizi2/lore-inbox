Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131430AbQLYPbP>; Mon, 25 Dec 2000 10:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130635AbQLYPbF>; Mon, 25 Dec 2000 10:31:05 -0500
Received: from Cantor.suse.de ([194.112.123.193]:39180 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131560AbQLYPa6>;
	Mon, 25 Dec 2000 10:30:58 -0500
Date: Mon, 25 Dec 2000 16:00:30 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test13pre4ac2
Message-ID: <20001225160030.A19858@gruyere.muc.suse.de>
In-Reply-To: <E149bsl-0005NV-00@the-village.bc.nu> <3A473192.ED7EE89C@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A473192.ED7EE89C@uow.edu.au>; from andrewm@uow.edu.au on Mon, Dec 25, 2000 at 10:37:54PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2000 at 10:37:54PM +1100, Andrew Morton wrote:
> Alan Cox wrote:
> > 
> > 2.4.0test13pre4-ac2
> >
> > o       Make smp cpu halt synchronous                   (Andi Kleen)
> 
> errr, Andi. 
> 
> We're asking all the other CPUs to call stop_this_cpu(), and then waiting
> for them to complete the call.
> 
> But stop_this_cpu() never returns, so the machine gets stuck.

Right, it's wrong. Thanks for spotting that.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
