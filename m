Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbUAKMLN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265846AbUAKMLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:11:13 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:63492 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265839AbUAKMKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:10:33 -0500
Subject: Re: [PATCH] Increase recursive symlink limit from 5 to 8
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Steve Youngs <sryoungs@bigpond.net.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <microsoft-free.87isjj0y1e.fsf@eicq.dnsalias.org>
References: <E1AeMqJ-00022k-00@minerva.hungry.com>
	 <2flllofnvp6.fsf@saruman.uio.no>
	 <microsoft-free.87isjj0y1e.fsf@eicq.dnsalias.org>
Content-Type: text/plain
Message-Id: <1073823028.1095.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 11 Jan 2004 13:10:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-11 at 08:01, Steve Youngs wrote:
> * Petter Reinholdtsen <pere@hungry.com> writes:
> 
>   >   Linux:         Symlink limit seem to be 6 path entities.
>   >   AIX:           Symlink limit seem to be 21 path entities.
>   >   HP-UX:         Symlink limit seem to be 21 path entities.
>   >   Solaris:       Symlink limit seem to be 21 path entities.
>   >   Irix:          Symlink limit seem to be 31 path entities.
>   >   Mac OS X:      Symlink limit seem to be 33 path entities.
>   >   Tru64 Unix:    Symlink limit seem to be 65 path entities.
> 
>   > I really think this limit should be increased in Linux.  Not sure
>   > how high it should go, but from 5 to somewhere between 20 and 64
>   > seem like a good idea to me.
> 
> 6 does seem pretty low.  What was the reason for setting it there?  Is
> there a downside to increasing it?

I think we cannot set this value much higher due to constraints in
kernel stack size, and this limits maximum recursion levels.

