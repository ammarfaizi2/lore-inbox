Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbTF3LQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 07:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbTF3LQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 07:16:20 -0400
Received: from dp.samba.org ([66.70.73.150]:3820 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265830AbTF3LQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 07:16:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16128.7306.58928.879567@cargo.ozlabs.ibm.com>
Date: Mon, 30 Jun 2003 21:18:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: [BUG]:   problem when shutting down ppp connection since 2.5.70
In-Reply-To: <3EFFA1EA.7090502@nortelnetworks.com>
References: <3EFFA1EA.7090502@nortelnetworks.com>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen writes:

> I have a pppoe dsl connection and I use the roaring penguin stuff that 
> comes default with Mandrake 9.  My connection is brought up at init 
> time.  With kernels past 2.5.69, if I try and shut down the connection I 
> get logs as follows:

Is this the user-mode pppoe or the in-kernel pppoe?  IOW, are you
using the pppoe channel type, or do you have the usermode program that
runs pppd behind a pty?

And, do you have any TCP connections open over the link when you take
it down?  What version of pppd is it?

Has anyone been able to replicate this without using pppoe?  The type
of channel shouldn't make any difference, but I just tried ppp over a
pty and it worked fine (except that Deflate is broken, but that's
another problem).

I have DSL and I could connect it up to a system running 2.5.  Maybe
I'll go try that now...

Paul.
