Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbRARPp5>; Thu, 18 Jan 2001 10:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132451AbRARPps>; Thu, 18 Jan 2001 10:45:48 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:8 "EHLO tellus.mine.nu")
	by vger.kernel.org with ESMTP id <S132255AbRARPpe>;
	Thu, 18 Jan 2001 10:45:34 -0500
Date: Thu, 18 Jan 2001 15:45:57 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Nick Urbanik <nicku@vtc.edu.hk>
cc: Kernel list <linux-kernel@vger.kernel.org>
Subject: [OT] Re: rsync + ssh fail on raid; okay on 2.2.x
In-Reply-To: <3A67056F.ECB60B8@vtc.edu.hk>
Message-ID: <Pine.LNX.4.30.0101181541440.12689-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Nick Urbanik wrote:

> Dear folks,
>
> I use rsync to transfer my mail (including this list) from work to home
> over ppp ussing OpenSSH 2.3.0.  I have no problem transfering  hundreds
> of megabytes of my babies' photos from a non-raid partition (going to
> work), but I get:
>
> nsmail/Inbox
> Write failed: Cannot allocate memory
> unexpected EOF in read_timeout

This is not the right place to ask (or answer), but anyway:

Make sure you do not use protocol version 2 with openssh 2.3.0, since it
is ***very*** broken, and more often than not fails to receive (and
transmit?) all data.

Try
	dd if=/dev/zero bs=1k count=100 | wc
and
	ssh machine dd if=/dev/zero bs=1k count=100 | wc

They should give you the same result.  If not, you have the broken ssh.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
