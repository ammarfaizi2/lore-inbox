Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbRACOyL>; Wed, 3 Jan 2001 09:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130850AbRACOyC>; Wed, 3 Jan 2001 09:54:02 -0500
Received: from hermes.mixx.net ([212.84.196.2]:53515 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130139AbRACOxu>;
	Wed, 3 Jan 2001 09:53:50 -0500
Message-ID: <3A533536.A1723DD6@innominate.de>
Date: Wed, 03 Jan 2001 15:20:38 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org
Subject: Re: scheduling problem?
In-Reply-To: <3A52609D.E1D466EA@innominate.de> <Pine.Linu.4.10.10101030545440.1057-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On Wed, 3 Jan 2001, Daniel Phillips wrote:
> 
> > Could you try this patch just to see what happens?  It uses semaphores
> > for the bdflush synchronization instead of banging directly on the task
> > wait queues.  It's supposed to be a drop-in replacement for the bdflush
> > wakeup/waitfor mechanism, but who knows, it may have subtly different
> > behavious in your case.
> 
> Semaphore timed out during boot, leaving bdflush as zombie.

Hmm, how could that happen?  I'm booted and running with that patch
right now and have beaten on it extensively - it sounds like something
else is broken.  Or maybe we've already established that - let me read
the thread again.

Which semaphore timed out, bdflush_request or bdflush_waiter?


--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
