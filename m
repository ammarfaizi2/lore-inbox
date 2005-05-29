Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVE2PcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVE2PcY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 11:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVE2PcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 11:32:24 -0400
Received: from smtpout.mac.com ([17.250.248.46]:60363 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261341AbVE2PcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 11:32:19 -0400
In-Reply-To: <opsrjg3nmvehbc72@grunion>
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <opsrjg3nmvehbc72@grunion>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <209FCBBF-BBFB-448B-9222-517EEC01D430@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: spinaphore conceptual draft (was discussion of RT patch)
Date: Sun, 29 May 2005 11:32:15 -0400
To: Joe Seigh <jseigh_02@xemaps.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 29, 2005, at 09:29:37, Joe Seigh wrote:
> If you went with a bakery algorithm and could tolerate FIFO service  
> order,
> you could use the expected service time as the ticket increment value
> instead of 1.  Before a thread gets a ticket, it examines the  
> expected queue
> wait time, the difference between the current ticket and the next  
> available
> ticket, to decide which increment to be applied to the next ticket  
> value.
> The two possible increment values would be the uncontended resource  
> service
> time and that value plus thread suspend/resume overhead.  If the  
> expected
> wait time is greater than the latter, it uses the latter as the  
> increment
> value and suspends rather than spins.

Ah, interesting idea. Perhaps we ought to try implementing several of  
the
ideas and benchmarking them.  I'll work on a user-space operable  
version of
my naive spinaphores, as well as an optimized assembly version, if I can
find the time in the next day or so.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



