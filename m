Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTEEHCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 03:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTEEHCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 03:02:22 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57705 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262008AbTEEHCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 03:02:22 -0400
Date: Mon, 5 May 2003 03:14:50 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: linux-kernel@vger.kernel.org
cc: Andi Kleen <ak@suse.de>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Message-ID: <Pine.LNX.4.44.0305050314240.26441-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 May 2003, Andi Kleen wrote:

> Ingo Molnar <mingo@redhat.com> writes:
> 
> > ie. if the binary anywhere has code that does:
> > 
> > 	system("/bin/sh")
> 
> You just need system(char *arg) { ... } (= in every libc). Then put
> /bin/sh somewhere and a pointer to it on the stack as argument and
> overwrite some return address on the stack to jump to it.

well, how do you put the pointer on the stack if your only way to get into
the ASCII-area is to stop the overflow early and use the final \0 ? [and
the parameter has to be put _after_ the enclosing \0. ] It's not 100%
impossible, but in the common case looks quite unlikely.

	Ingo

