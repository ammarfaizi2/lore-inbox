Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272374AbTGaEkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 00:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272380AbTGaEkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 00:40:06 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:30474 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S272374AbTGaEj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 00:39:59 -0400
Date: Thu, 31 Jul 2003 14:39:45 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Frank v Waveren <fvw@var.cx>
cc: linux-kernel@vger.kernel.org, <Andries.Brouwer@cwi.nl>,
       <linux-crypto@nl.linux.org>
Subject: Re: 2.6.0-test2+Util-linux/cryptoapi
In-Reply-To: <1059621603HIC.fvw@tracks.var.cx>
Message-ID: <Mutt.LNX.4.44.0307311420080.21102-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003, Frank v Waveren wrote:

> Moving to the slightly more ontopic stuff for lk@vger: Is access to
> the cryptoapi algorithms exposed to userspace yet?

No, there is no point (apart from testing) unless the kernel API is 
providing access to crypto hardware.


> Thirdly, has the encryption setup changed again since 2.4.x with hvr's
> testing cryptoapi stuff? I have a filesystem encrypted with 256 bits
> serpent, yet it won't decrypt using 2.6.0-test2 and util-linux 2.12.

The kerneli serpent implementation is incorrect (it's reversed, a common
implementation problem with this algorithm).

> Lastly: Why the move from a /proc/crypto directory containing files
> for all the algorithms to one monolithic /proc/crypto file? Isn't the
> former a lot nicer from the userspace programmer's point of view?

Possibly, although it's probably too late to change now for 2.6.


- James
-- 
James Morris
<jmorris@intercode.com.au>


