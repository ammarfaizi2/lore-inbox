Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbUB0XRo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbUB0XRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:17:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:40120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263209AbUB0XRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:17:09 -0500
Date: Fri, 27 Feb 2004 15:22:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ralph Campbell <ralphc@nikto.sfbay.sun.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: wait_queue_t is fundamentally broken; need pthread_cond_t
In-Reply-To: <200402272309.i1RN98bk002304@nikto.sfbay.sun.com>
Message-ID: <Pine.LNX.4.58.0402271521370.1078@ppc970.osdl.org>
References: <200402272309.i1RN98bk002304@nikto.sfbay.sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Feb 2004, Ralph Campbell wrote:
>
> [1.] One line summary of the problem:    
> 	wait_queue_t is fundamentally broken; need pthread_cond_t

One-line summary response:

	use "wait_event()".

And no, we sure as hell don't need those stupid pthread condition 
variables. Just use wait-queues properly instead.

		Linus
