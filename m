Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284997AbRLFFtN>; Thu, 6 Dec 2001 00:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284826AbRLFFtE>; Thu, 6 Dec 2001 00:49:04 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:23372 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284806AbRLFFst>; Thu, 6 Dec 2001 00:48:49 -0500
Date: Thu, 6 Dec 2001 00:48:48 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Carlo Wood <carlo@alinoe.com>, linux-kernel@vger.kernel.org
Subject: Re: kqueue, kevent - kernel event notification mechanism
Message-ID: <20011206004848.C29061@redhat.com>
In-Reply-To: <20011206013857.A17313@alinoe.com> <E16Bmqo-0008Fj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Bmqo-0008Fj-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 06, 2001 at 12:57:21AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 12:57:21AM +0000, Alan Cox wrote:
> The API isnt directly the problem. In fact you can make a fine scalable select
> by implementing
> 
> 	poll_setup(..............)
> 	poll_add/poll_remove
> 	poll_wait
> 
> as multiple calls giving basically the same interface that apps expected
> anyway.  Take a look at the various /dev/poll experimental interfaces and
> bits of code.

My aio patches already have a poll operation, however it acts as a one shot 
operation: an async poll does not complete until the state indicates 
readiness or it is cancelled.  That's needed as there is a 1-1 relationship 
between submitted aio operations and the space in the completion ring.  Still, 
it looks like it will work quite nicely as a means of accelerating exiting 
poll() based servers.

		-ben

		-ben

