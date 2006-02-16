Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWBPUsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWBPUsp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWBPUsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:48:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:35796 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964795AbWBPUsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:48:45 -0500
Date: Thu, 16 Feb 2006 12:47:58 -0800
From: Paul Jackson <pj@sgi.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, drepper@redhat.com,
       tglx@linutronix.de, arjan@infradead.org, akpm@osdl.org
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
Message-Id: <20060216124758.d51befd5.pj@sgi.com>
In-Reply-To: <1140111257.21681.26.camel@localhost.localdomain>
References: <20060216094130.GA29716@elte.hu>
	<1140107585.21681.18.camel@localhost.localdomain>
	<20060216172435.GC29151@elte.hu>
	<1140111257.21681.26.camel@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel wrote:
> "on the surface" you could manipulate the futex_offset to
> access memory unrelated to the futex structure .

If a piece of malicious code has wormed its way far enough into my
application to be manipulating this list, then I don't think that code
will gain any further advantage by manpulating this list.  I think my
application is already powned.

That malicious code would have no need to have the kernel futext handling
code do its dirty work indirectly via manipulations of this list.  It can
just do the dirty work directly.

All Ingo needs to insure is that the kernel will assume no more
priviledge when reading/writing this list than the current task had,
from user space, reading/writing this list.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
