Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271487AbRHTRmw>; Mon, 20 Aug 2001 13:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271496AbRHTRmn>; Mon, 20 Aug 2001 13:42:43 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:1290 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271487AbRHTRm3>; Mon, 20 Aug 2001 13:42:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: llx@swissonline.ch, linux-kernel@vger.kernel.org
Subject: Re: misc questions about kernel 2.4.x internals
Date: Mon, 20 Aug 2001 19:49:05 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200108201452.f7KEqxk18219@mail.swissonline.ch>
In-Reply-To: <200108201452.f7KEqxk18219@mail.swissonline.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820174231Z16441-32386+48@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 20, 2001 04:52 pm, Christian Widmer wrote:
> 3) i had a look at the ll_rw_block and realised that it can block when there 
> are to many buffers locked. when i use generic_make_request can i be 
> shure that i wont block so that i can call it in a tasklet and don't need to
> switch to a kernel thread? i think that also needs that clustering function 
> __make_request may not block. does it or does it not?

It blocks on the availability of a struct request, look at __get_request_wait.
This is how we do IO throttling in 2.4.8/9.

--
Daniel
