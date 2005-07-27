Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVG0UhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVG0UhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVG0Uef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:34:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34519
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262367AbVG0UdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:33:20 -0400
Date: Wed, 27 Jul 2005 13:33:17 -0700 (PDT)
Message-Id: <20050727.133317.115640883.davem@davemloft.net>
To: rml@novell.com
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       ttb@tentacle.dhs.org
Subject: Re: [patch] inotify: ppc64 syscalls.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1122496262.21253.190.camel@betsy>
References: <1122485496.21253.170.camel@betsy>
	<20050727.132701.115907512.davem@davemloft.net>
	<1122496262.21253.190.camel@betsy>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Love <rml@novell.com>
Date: Wed, 27 Jul 2005 16:31:02 -0400

> On Wed, 2005-07-27 at 13:27 -0700, David S. Miller wrote:
> 
> > You'll notice that sys_ppc32.c has a ton of shims which purely
> > exist to sign extend "int" system call arguments.  Sparc64 does
> > something similarly, but in assembler so that we don't eat the
> > overhead of a full stack frame just to sign extend arguments.
> 
> Yah, but it looked like they did the sign extend thing for every int but
> file descriptors, and fd's are the only int's we have.

Ok, works for me :-)
