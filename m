Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267614AbUH0WDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbUH0WDJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 18:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUH0V6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:58:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:10409 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262329AbUH0Vx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:53:26 -0400
Date: Fri, 27 Aug 2004 14:52:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Craig Milo Rogers <rogers@isi.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       webcam@smcc.demon.nl
Subject: Re: Termination of the Philips Webcam Driver (pwc)
In-Reply-To: <Pine.LNX.4.60.0408272225140.9310@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0408271448400.14196@ppc970.osdl.org>
References: <20040826233244.GA1284@isi.edu>  <20040827004757.A26095@infradead.org>
  <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org>  <20040827094346.B29407@infradead.org>
  <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org> <1093628254.15313.14.camel@gonzales>
 <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
 <Pine.LNX.4.60.0408272225140.9310@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004, Anton Altaparmakov wrote:
> 
> So how come we allow drivers which load binary firmware into the kernel?  
> And there are plenty of them...

Beause firmware is a clearly separate part.

It's not a part of the kernel at all - it doesn't even run on the same 
CPU, for christ sake! Firmware if anything is _further_ removed from the 
kernel than user programs are.

> There isn't very much difference between binary firmware and the binary 
> module in this case. 

Go back and read this same thread three or four months ago. You are 
barking up the wrong tree. There is a HUGE difference between a binary 
kernel module running inside the kernel, and a firmware image running on 
another CPU entirely behind a bridge. 

There's a huge conceptual separation, but there's also an actual 
_physical_ separation. How much different do you want things to be?

Firmware on a device is logically equivalent to the kernel running on
another machine entirely. A USB device firmware is from a logical (and
technical) standpoint not really any different than a fileserver running
on a different computer.

		Linus
