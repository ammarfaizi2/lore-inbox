Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276736AbRJPVem>; Tue, 16 Oct 2001 17:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276737AbRJPVec>; Tue, 16 Oct 2001 17:34:32 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:4617 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S276736AbRJPVeX>; Tue, 16 Oct 2001 17:34:23 -0400
Subject: Re: [PATCH] various minor cleanups against 2.4.13-pre3 - comments
	requested
From: Robert Love <rml@tech9.net>
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BCC8C88.58BBCC39@eisenstein.dk>
In-Reply-To: <3BCC8C88.58BBCC39@eisenstein.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.12.08.08 (Preview Release)
Date: 16 Oct 2001 17:34:34 -0400
Message-Id: <1003268078.868.26.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-16 at 15:37, Jesper Juhl wrote:
> init/main.c : parse_options()
>         The check that adds "line" to either "envp_init" or "argv_init"
> checks to see if the buffers are full and break;s the while() loop
> if _either_ buffer is full - it should use continue; so both buffers can
> get a chance to fill up. Robert M. Love should get credit for finding
> this one, I found it by looking at an old patch of his, and I just checked
> to see if it was still there and read the code to see if it was correct.

Thanks for running with this.

Now, for the love of all things holy, can _someone_ either tell me what
is wrong with this patch or merge it already?  I originally wrote this
for 2.2!

It seems clear to me that we lose either the environment vars or
command-line args when the other one fills up...

	Robert Love

