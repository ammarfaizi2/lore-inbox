Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRCBSgU>; Fri, 2 Mar 2001 13:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129402AbRCBSgL>; Fri, 2 Mar 2001 13:36:11 -0500
Received: from laird.ocp.internap.com ([64.94.114.35]:47201 "EHLO
	laird.ocp.internap.com") by vger.kernel.org with ESMTP
	id <S129401AbRCBSgG>; Fri, 2 Mar 2001 13:36:06 -0500
Date: Fri, 2 Mar 2001 10:35:33 -0800 (PST)
From: Scott Laird <laird@internap.com>
X-X-Sender: <laird@laird.ocp.internap.com>
To: <kuznet@ms2.inr.ac.ru>
cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Another rsync over ssh hang (repeatable, with 2.4.1 on both
 ends)
In-Reply-To: <200103021808.VAA00511@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0103021031120.17365-100000@laird.ocp.internap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Mar 2001 kuznet@ms2.inr.ac.ru wrote:
> > together to put 2.2.18 on this machine.  I can't guarantee when I'll
> > be able to do this though.
>
> You planned to make more accurate strace on Monday, if I remember correctly.
> Now it is not necessary, Scott's one is enough to understand that
> some problem exists and cannot be explained by buggy 2.2.15.

One data point on my hang -- I increased
/proc/sys/net/core/wmem_{max,default} from 64k to 256k, and then increased
/proc/sys/net/ipv5/tcp_wmem from "4096 16384 131072" to "16384 65536
262144", and the hangs seem to have either stopped or (more likely)
drastically reduced in frequency.  I was able to rsync a couple GB without
stalling.

I can perform more tests, if anyone has anything in particular that they'd
like to see.


Scott

