Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129876AbQJ0K0P>; Fri, 27 Oct 2000 06:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129873AbQJ0K0H>; Fri, 27 Oct 2000 06:26:07 -0400
Received: from Cantor.suse.de ([194.112.123.193]:19461 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129866AbQJ0KZw>;
	Fri, 27 Oct 2000 06:25:52 -0400
Date: Fri, 27 Oct 2000 12:25:49 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Andi Kleen <ak@suse.de>, Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>, kumon@flab.fujitsu.co.jp,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Negative scalability by removal of lock_kernel()?(Was: Strange performance behavior of 2.4.0-test9)
Message-ID: <20001027122549.A22417@gruyere.muc.suse.de>
In-Reply-To: <39F92187.A7621A09@timpanogas.org> <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>, <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>; <20001027094613.A18382@gruyere.muc.suse.de> <39F957BC.4289FF10@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39F957BC.4289FF10@uow.edu.au>; from andrewm@uow.edu.au on Fri, Oct 27, 2000 at 09:23:56PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 09:23:56PM +1100, Andrew Morton wrote:
> Andi Kleen wrote:
> > 
> > When you have two CPUs contending on common paths it is better to do:
> > [ spinlock stuff ]
> 
> Andi, if the lock_kernel() is removed then the first time the CPUs will butt heads is on a semaphore.  This is much more expensive.
> 
> I bet if acquire_fl_sem() and release_fl_sem() are turned into lock_kernel()/unlock_kernel() then the scalability will come back.

To test your theory it would be enough to watch context switch rates in top



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
