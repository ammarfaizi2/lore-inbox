Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbRGDXCj>; Wed, 4 Jul 2001 19:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266575AbRGDXC3>; Wed, 4 Jul 2001 19:02:29 -0400
Received: from martnet.com ([146.145.176.8]:53965 "EHLO home.martnet.com")
	by vger.kernel.org with ESMTP id <S266573AbRGDXCR>;
	Wed, 4 Jul 2001 19:02:17 -0400
Date: Wed, 4 Jul 2001 19:02:08 -0400
From: John Guthrie <guthrie@home.martnet.com>
Message-Id: <200107042302.TAA08608@home.martnet.com>
To: guthrie@martnet.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [PATCH] small patch to ide-tape.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> wrote:
> > This patch adds a missing semicolon that is noticed only if you define
> > IDETAPE_DEBUG_LOG_VERBOSE:
> > 
> > John Guthrie
> > guthrie@martnet.com
> 
> It makes me curious, why do you need to define
> IDETAPE_DEBUG_LOG_VERBOSE?
> 
> I fixed some stuff with files not restoring properly
> with last block corrupt. Talking with Andre and Gadi now.
> What is your problem?

I sent out some posts earlier on this.  To summarize, I have an HP Colorado
5GB IDE tape drive.  I have been able to use mt to move the tape forward, find
out where the tape is positioned, rewind it, etc.  I have also been able to
use tar to write to the tape drive.  When I try to use tar to read from the
tape drive though, I get the following as output:

tar: /dev/ht0: Cannot read: Input/output error
tar: At beginning of tape, quitting now
tar: Error is not recoverable: exiting now

The following also appears in dmesg output when I try to run the tar command:

ide-tape: Reached idetape_chrdev_open
ide-tape: ht0: I/O error, pc =  8, key =  5, asc = 2c, ascq =  0

Willem Riede suggested to me that I try turning IDETAPE_DEBUG_LOG_VERBOSE on
to help with debugging.  That iswhen I ran into this line that as missing a
semicolon.

John Guthrie
guthrie@martnet.com
