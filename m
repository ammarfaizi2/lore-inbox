Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130047AbRBLKGC>; Mon, 12 Feb 2001 05:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130048AbRBLKFw>; Mon, 12 Feb 2001 05:05:52 -0500
Received: from ns.suse.de ([213.95.15.193]:21002 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130047AbRBLKFm>;
	Mon, 12 Feb 2001 05:05:42 -0500
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <E14SFbG-0006WR-00@the-village.bc.nu>
From: Andi Kleen <freitag@alancoxonachip.com>
Date: 12 Feb 2001 11:05:18 +0100
In-Reply-To: Alan Cox's message of "12 Feb 2001 10:54:49 +0100"
Message-ID: <ouplmrckyht.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Suppose vesafb did something like this, dropping the printk lock
> 
> 	if(test_and_set_bit(0, &vesafb_lock))
> 	{
> 		if(in_interrupt())
> 		{
> 			// remember which bit of the dmesg ring to queue
> 			queued_writes=1;
> 			return;


Just what happens when you run out of dmesg ring in an interrupt ?


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
