Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVAGRvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVAGRvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVAGRsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:48:39 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:43973 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261379AbVAGRqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:46:10 -0500
Message-ID: <41DECAA8.3040909@nortelnetworks.com>
Date: Fri, 07 Jan 2005 11:45:12 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
References: <41DE9D10.B33ED5E4@tv-sign.ru>	 <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org> <1105113998.24187.361.camel@localhost.localdomain>
In-Reply-To: <1105113998.24187.361.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2005-01-07 at 16:17, Linus Torvalds wrote:
> 
>>it a "don't do that then", and I'll wait to see if people do. I can't
>>think of anything that cares about performance that does that anyway:  
>>becuase system calls are reasonably expensive regardless, anybody who
>>cares at all about performance will have buffered things up in user space.
> 
> 
> Actually I found a load of apps that do this but they don't care about
> performance. Lots of people have signal handlers that just do
> 
> 	write(pipe_fd, &signr, sizeof(signr))
> 
> so they can drop signalled events into their event loops

I would be one of those people, although I do pass the signal 
information as well.

Chris

