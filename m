Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbTD0AwE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 20:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbTD0AwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 20:52:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6415 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263161AbTD0AwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 20:52:03 -0400
Date: Sat, 26 Apr 2003 18:04:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow ptrace and /proc/PID/mem to read fixmap pages
In-Reply-To: <200304262346.h3QNkL129881@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0304261802190.12273-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Apr 2003, Roland McGrath wrote:
> 
> This patch is i386-specific and should probably be done another way, but
> it's what I am using now.  It works and is well-tested. 

It looks to me like it will cause NULL pointer dereferences if the user 
asks for something that is inside a pmd isn't mapped.

Maybe that won't happen for the FIXADDR range, but this is just not 
acceptable. We don't do code without error handling in the kernel.

		Linus

