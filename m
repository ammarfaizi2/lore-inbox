Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUFWW5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUFWW5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUFWW5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:57:04 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:19469 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262009AbUFWW4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:56:52 -0400
Date: Thu, 24 Jun 2004 00:56:40 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [BUG 2.6.7] : Partition table display bogus...
Message-ID: <20040623225640.GE3072@pclin040.win.tue.nl>
References: <20040623220557.GA26199@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623220557.GA26199@bougret.hpl.hp.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 03:05:57PM -0700, Jean Tourrilhes wrote:

> 	Playing with 2.6.7 on my laptop. I realised Lilo did not work
> anymore. Look further, and the partition table was all screwed up.

Not so pessimistic.

Old situation:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
New situation:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >

Nothing wrong with that partition table.

Maybe you get unhappy because of the fdisk output, but that only
shows that you have an old fdisk. Also there nothing wrong.

Ah - so the only wrong thing must be the fact that lilo stopped working.
I suppose things will improve if you give it the "linear" (or "lba32") flag.

What changed is that the kernel no longer attempts at guessing a geometry.
If such guessing is required, user space must do so itself.

Andries
