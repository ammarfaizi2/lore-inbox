Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317470AbSHHLmF>; Thu, 8 Aug 2002 07:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSHHLmF>; Thu, 8 Aug 2002 07:42:05 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:52141 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S317470AbSHHLmE>;
	Thu, 8 Aug 2002 07:42:04 -0400
Date: Thu, 8 Aug 2002 13:45:40 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: martin@dalecki.de, "Adam J. Richter" <adam@yggdrasil.com>,
       <alan@lxorguk.ukuu.org.uk>, <Andries.Brouwer@cwi.nl>,
       <johninsd@san.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
Message-ID: <20020808114540.GA633@win.tue.nl>
References: <3D523B25.5080105@evision.ag> <Pine.LNX.4.44.0208081139350.3618-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208081139350.3618-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 12:01:27PM +0200, Ingo Molnar wrote:

> just tested 2.5.29-vanilla, it works, without and with linear.
> 2.5.30-vanilla is broken without linear, works with linear.

Excellent, precisely as expected.


[Yes, I don't know why an entire thread blossomed up around
something very well understood. Many wrong statements were
made, but I am too lazy to go and refute them all.

Concerning what happened: Long ago, the kernel did some more or
less silly things to get a geometry - for example, asking the
BIOS and the disk; but that did not produce the desired results
and someone added (in 1.3.61) some code to override the geometry
found this way by something guessed from the partition table,
in the good old tradition: is there a bug in a user space program?
fix it in the kernel. That is the [PTBL] you see in kernel boot
messages. Now that this kernel fix has been removed in a small
cleanup operation, lilo will have to be fixed, or people will
have to invoke lilo with linear, or so.

The full truth is more complicated, but this is the full
truth in your case.]

Andries
