Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTIPQRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 12:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTIPQRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 12:17:12 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:39058 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261916AbTIPQRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 12:17:11 -0400
X-Sender-Authentication: net64
Date: Tue, 16 Sep 2003 18:17:08 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Timothy Miller <miller@techsource.com>
Cc: alan@lxorguk.ukuu.org.uk, marcelo.tosatti@cyclades.com.br,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-Id: <20030916181708.5b63ed00.skraw@ithnet.com>
In-Reply-To: <3F6730F6.8040508@techsource.com>
References: <20030916102113.0f00d7e9.skraw@ithnet.com>
	<Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet>
	<20030916153658.3081af6c.skraw@ithnet.com>
	<1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk>
	<20030916172057.148a5741.skraw@ithnet.com>
	<3F6730F6.8040508@techsource.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 11:49:10 -0400
Timothy Miller <miller@techsource.com> wrote:

> Alan Cox wrote:
> > The kernel has no idea what you will do with given ram. It does try to
> > make some guesses but you are basically trying to paper over hardware
> > limits.
> 
> 
> Maybe not what you WILL DO, but what you HAVE DONE.  Those tasks which 
> have done the most DMA-requiring I/O could get preference for low 
> memory.  No?
> 
> Yeah, I know.. show you the code.  :)

That really sounds complex and therefore I would not try that in first place.
And it does not sound like a solution to my special problem of few tasks
operating on a lot of data (a lot more than fits to physical mem). For this
type of situation it would be really intelligent not to give away non-dma-able
memory. How can the kernel do that?
At least it knows that there are I/O devices that cannot cope with the mem it
is presenting. This sounds in fact simple.
The problem is: what _can_ be done with this type of mem at all?
It does not even help a lot if there are other devices that can handle it,
because you still must face the fact of a simple file-copy from such a capable
device to one that is not.
No wonder that the gurus did not have any good idea yet ;-)

Regards,
Stephan
