Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTKHTqU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 14:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTKHTqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 14:46:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:34763 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262115AbTKHTqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 14:46:19 -0500
Date: Sat, 8 Nov 2003 11:46:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: Anton Blanchard <anton@samba.org>,
       Denis <vda@port.imtp.ilyichevsk.odessa.ua>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-test6: nanosleep+SIGCONT weirdness
In-Reply-To: <3FAD418D.2080508@redhat.com>
Message-ID: <Pine.LNX.4.44.0311081144560.1639-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Nov 2003, Ulrich Drepper wrote:
> 
> Of course it's supported.  the clock_* functions are in librt.  And they
> are supported and, when working, greatly increase the usability.  The
> old user-level implementation is as good as we get it but really not up
> to the job.

Okey-dokey - I verified that the clock_nanosleep() function is also 
broken.

I'll see if I can see what the mess is all about. That posix-timer "retry" 
code really is a pretty horrible thing.

		Linus


