Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264922AbRFUG55>; Thu, 21 Jun 2001 02:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264923AbRFUG5s>; Thu, 21 Jun 2001 02:57:48 -0400
Received: from www.wen-online.de ([212.223.88.39]:35337 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264922AbRFUG5e>;
	Thu, 21 Jun 2001 02:57:34 -0400
Date: Thu, 21 Jun 2001 08:56:53 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac15
In-Reply-To: <Pine.LNX.4.21.0106210127150.14247-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106210836340.1043-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Marcelo Tosatti wrote:

> >  2  4  2  77084   1524  18396  66904   0 1876   108  2220 2464 66079   198   1
                                                                   ^^^^^
> Ok, I suspect that GFP_BUFFER allocations are fucking up here (they can't
> block on IO, so they loop insanely).

Why doesn't the VM hang the syncing of queued IO on these guys via
wait_event or such instead of trying to just let the allocation fail?
(which seems to me will only cause the allocation to be resubmitted,
effectively changing nothing but adding overhead)  Does failing the
allocation in fact accomplish more than what I'm (uhoh:) assuming?

	-Mike

