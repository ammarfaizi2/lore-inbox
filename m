Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130922AbRCFEqJ>; Mon, 5 Mar 2001 23:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130923AbRCFEps>; Mon, 5 Mar 2001 23:45:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40463 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130922AbRCFEpk>; Mon, 5 Mar 2001 23:45:40 -0500
Date: Mon, 5 Mar 2001 20:05:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Jeremy Hansen <jeremy@xxedgexx.com>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <l03130307b6ca031531fc@[192.168.239.101]>
Message-ID: <Pine.LNX.4.10.10103051957240.778-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Mar 2001, Jonathan Morton wrote:
> 
> It's pretty clear that the IDE drive(r) is *not* waiting for the physical
> write to take place before returning control to the user program, whereas
> the SCSI drive(r) is.

This would not be unexpected.

IDE drives generally always do write buffering. I don't even know if you
_can_ turn it off. So the drive claims to have written the data as soon as
it has made the write buffer.

It's definitely not the driver, but the actual drive.

		Linus

