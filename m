Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUFPD5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUFPD5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUFPD5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:57:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:61606 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266117AbUFPD5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 23:57:14 -0400
Date: Tue, 15 Jun 2004 20:56:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [PATCH] make ps2 mouse work ...
Message-Id: <20040615205611.1e9cbfcc.akpm@osdl.org>
In-Reply-To: <20040615191023.G28403@mvista.com>
References: <20040615191023.G28403@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun Sun <jsun@mvista.com> wrote:
>
> 
> I found this problem on a MIPS machine.  The problem is 
> likely to happen on other register-rich RISC arches too.
> 
> cmdcnt needs to be volatile since it is modified by
> irq routine and read by normal process context.

volatile is not the preferred way to fix this up.  This points at either a
locking error in the psmouse driver or a missing "memory" thingy in the
mips port somewhere.

Please describe the bug which led to this patch.  Where was it getting stuck?

