Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264527AbTCYUhr>; Tue, 25 Mar 2003 15:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264528AbTCYUhr>; Tue, 25 Mar 2003 15:37:47 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:6927 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264527AbTCYUhq>; Tue, 25 Mar 2003 15:37:46 -0500
Date: Tue, 25 Mar 2003 20:48:54 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Helge Hafting <helgehaf@aitel.hist.no>, Jurriaan <thunder7@xs4all.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.65 + matrox framebuffer: life is good!
In-Reply-To: <74B3EA2366@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0303252047520.6228-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Probably worst problem currently is cursor code: it calls imgblit from interrupt
> > > context, and matroxfb's accelerated procedures are not ready to handle
> > > such thing (patch hooks cursor call much sooner for primary mga head).
> > 
> > Fixed now. Also I have a patch that properly fixes image.depth = 0 hack. I 
> > will post for people to test. Folks please test the code.
> 
> AFAIK you only fixed kmalloc problem. Or is cursor callback disallowed
> while doing imgblit/copyarea/fillrect ?

Take a look at fb_get_buffer_offset in fbmem.c and tell me if it is 
enough for you. I do plan to move to using a semaphore instead of a 
spinlock tho. 


