Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131557AbQKQALb>; Thu, 16 Nov 2000 19:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131625AbQKQALV>; Thu, 16 Nov 2000 19:11:21 -0500
Received: from mhaaksma-3.dsl.speakeasy.net ([64.81.17.226]:521 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S131557AbQKQALP>;
	Thu, 16 Nov 2000 19:11:15 -0500
Subject: Re: APM oops with Dell 5000e laptop
From: Brad Douglas <brad@neruo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dax@gurulabs.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <E13wWoN-0008PC-00@the-village.bc.nu>
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 17 Nov 2000 07:40:49 +0800
Mime-Version: 1.0
Message-Id: <20001117001119Z131557-521+765@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I do not believe so.  I tend to think that detecting these broken models is a waste of kernel code (especially, if there's an effort to correct the problem).
> 
> One idea the Dell folks suggested is walking the SMBIOS data table. That happens
> to be something I want to do as its the only good way I know to get
> 
>       o       Cache sizes on older machines
>       o       The type of monitoring device (lm78 etc) attached
>       o       slot information

You cannot base this on the Type 1: System Information as a method of identifying the system.

I have in front of me a Dell 5000e and a Compal N30W2, which are the exact same machines.  A SMBIOS dump shows different identification information for both machines.  In the System Information struct, one says Compal Electronics and the other says Dell Computer Corporation for the manufacturer.  The Product Names are also (obviously) different as well.
So far, I have been unable to find anything in the dump that identifies the two machines as the same.

I don't believe doing this just to make a Dell detect properly is the right way to go (regardless of my bias).  I think the best we can do build a list of the systems that are the same, but it's certainly not a preferred way.

Any suggestions?

Brad Douglas
brad@neruo.com
brad@tuxtops.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
