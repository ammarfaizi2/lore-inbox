Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUBCXE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUBCXEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:04:25 -0500
Received: from mail.onairusa.com ([64.2.100.242]:48473 "EHLO
	host21.onairusa.com") by vger.kernel.org with ESMTP id S266185AbUBCXEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:04:22 -0500
Message-Id: <200402032304.i13N4KFh014280@host21.onairusa.com>
Subject: Re: [PATCH] es1371.c - 8 bit stereo (kernel version 2.4.24)
To: linux-kernel@vger.kernel.org
Date: Tue, 3 Feb 2004 17:04:20 -0600 (CST)
Reply-To: bnelson@onairusa.com
From: "Bob Nelson" <bnelson@onairusa.com>
X-Mailer: Elm 2.5 PL3 running on Linux 2.4.20
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: This is a copy of original e-mail response sent inadvertently
      to only Thomas Sailer. This corrects that oversight by sending
      it along to the linux-kernel mailing list.

On Tue Feb  3 07:34:44 2004 Thomas Sailer wrote the following:

> On Tue, 2004-02-03 at 01:57, Bob Nelson wrote:
>
> > Although the code in the ``es1371.c'' source is not lavishly commented,
>
> That's because the hardware itself is not very well documented. I'm
> having serious trouble understanding what the P2_ENDINC bits should do.

Duly noted, Tom...and thanks for the speedy response to the suggested
patch.

> > it appears that the intent of the author is to use 1 as the operand
> > of the shift for 8-bit audio. However, the original code does not take
> > into account ``SCTRL_P2SMB'', 8-bit stereo. The patch results in 1 being
> > used as the operand for any 8-bit audio file, stereo or mono.
>
> Have you also tried 16bit mono and stereo with your patch? does that
> still work?

Indeed I have -- as you might guess -- the vast majority of the audio is
16-bit and I had to be very careful to verify that the patch for a
``corner condition'' of the unusual 8-bit stereo file didn't break the
normal condition.
