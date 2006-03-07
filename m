Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWCGBiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWCGBiA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbWCGBiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:38:00 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:56978 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751294AbWCGBh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:37:59 -0500
Message-ID: <440CE3DB.5050103@cfl.rr.com>
Date: Mon, 06 Mar 2006 20:37:31 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Dan Aloni <da-x@monatomic.org>
CC: Benjamin LaHaise <bcrl@kvack.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Status of AIO
References: <20060306062402.GA25284@localdomain> <20060306211854.GM20768@kvack.org> <20060307013049.GA19775@localdomain>
In-Reply-To: <20060307013049.GA19775@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aio_* functions are library routines in glibc that are implemented by 
spawning threads to use the normal kernel io syscalls.  They don't use 
real async IO in the kernel.  I'm not sure why you didn't see the 
thread, but if you look up the glibc sources you will see how it works.

To use the kernel aio you make calls to io_submit().

Dan Aloni wrote:
> Well, I've written a small test app to see if it works with network
> sockets and apparently it did for that small test case (connect() 
> with aio_read(), loop with aio_error(), and aio_return()). I thought 
> perhaps the glibc implementation was running behind the scene, so I've 
> checked to see if it a thread was created in the background and I 
> there wasn't any thread. 
> 

