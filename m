Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129034AbQKFH3T>; Mon, 6 Nov 2000 02:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129036AbQKFH27>; Mon, 6 Nov 2000 02:28:59 -0500
Received: from waste.org ([209.173.204.2]:50209 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129034AbQKFH24>;
	Mon, 6 Nov 2000 02:28:56 -0500
Date: Mon, 6 Nov 2000 01:28:45 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.21.0011060715431.14068-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10011060118040.8248-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, David Woodhouse wrote:

> On Mon, 6 Nov 2000, Oliver Xymoron wrote:
> 
> > Hopefully not. The standard examples (mixer levels, etc) are better
> > handled with a userspace tool hooked by modprobe. This even gets
> > persistence across reboots if that's what's wanted.
> 
> Implement a way for a userspace tool to get the correct mixer levels in
> place at the time the sound hardware is reset, so there are no glitches in
> the levels, and I'll agree with you.

If I understand you correctly:

process 1         process 2
open(/dev/dsp)
modprobe->        
                  load module
                  init module   (can't remember which context, actually)
start writing     
                  set mixer levels

Is there any reason we ever want to unblock process 1 before process 2
terminates?

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
