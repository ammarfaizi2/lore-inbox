Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751725AbWCHGaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbWCHGaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 01:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWCHGaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 01:30:55 -0500
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:25571 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751440AbWCHGaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 01:30:55 -0500
Date: Wed, 8 Mar 2006 01:25:47 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>,
       Mike Christie <michaelc@cs.wisc.edu>,
       Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Message-ID: <200603080129_MC3-1-BA15-47C9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.64.0603061917330.3573@g5.osdl.org>

On Mon, 6 Mar 2006 19:20:13 -0800, Linus Torvalds wrote:

> > When someone converted the *buffer* allocation to kzalloc they
> > also removed the the memset for the *packet_cmmand* struct.
> > 
> > The
> > 
> > memset(&cgc, 0, sizeof(struct packet_command));
> > 
> > should be added back I think.
> 
> Good eyes. I bet that's it.

Heh.  This exact fix was posted to linux-kernel by Lee Schermerhorn
three weeks ago:

 Date: Wed, 15 Feb 2006 14:07:37 -0500
 From: Lee Schermerhorn <lee.schermerhorn@hp.com>
 Subject: [PATCH] 2.6.16-rc3-mm1 - restore zeroing of packet_command
        struct  in sr_ioctl.c
 To: linux-kernel <linux-kernel@vger.kernel.org>
 Cc: Andrew Morton <akpm@osdl.org>
 Message-ID: <1140030457.6619.3.camel@localhost.localdomain>


-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

