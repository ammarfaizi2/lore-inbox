Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUBPHC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 02:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265384AbUBPHC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 02:02:28 -0500
Received: from dp.samba.org ([66.70.73.150]:6361 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265377AbUBPHCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 02:02:19 -0500
Date: Mon, 16 Feb 2004 17:59:26 +1100
From: Anton Blanchard <anton@samba.org>
To: dan carpenter <error27@email.com>
Cc: ltp-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Announce] Strace Test
Message-ID: <20040216065926.GA22323@krispykreme>
References: <20040216052257.A2C971D7214@ws3-3.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216052257.A2C971D7214@ws3-3.us4.outblaze.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Strace Test uses a modified version of strace 4.5.1.  
> Instead of printing out information about system calls, 
> the modified version calls the syscalls with improper 
> values.  A patch and a binary for i386 are included 
> in the strace_test tar ball.

Nasty. I like it :)

Im running it on ppc32 at the moment, will test ppc64 next. Might be 
worth changing maxed to a long and passing back -1UL:

int
maxed(arg)
int arg;
{
       return 0xffffffff;
}

Anton
