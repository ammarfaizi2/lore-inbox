Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVG0VXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVG0VXB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVG0Ucb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:32:31 -0400
Received: from peabody.ximian.com ([130.57.169.10]:11960 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262367AbVG0UbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:31:01 -0400
Subject: Re: [patch] inotify: ppc64 syscalls.
From: Robert Love <rml@novell.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       ttb@tentacle.dhs.org
In-Reply-To: <20050727.132701.115907512.davem@davemloft.net>
References: <1122479106.21253.158.camel@betsy>
	 <20050727095539.602fcc4a.akpm@osdl.org> <1122485496.21253.170.camel@betsy>
	 <20050727.132701.115907512.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 16:31:02 -0400
Message-Id: <1122496262.21253.190.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 13:27 -0700, David S. Miller wrote:

> You'll notice that sys_ppc32.c has a ton of shims which purely
> exist to sign extend "int" system call arguments.  Sparc64 does
> something similarly, but in assembler so that we don't eat the
> overhead of a full stack frame just to sign extend arguments.

Yah, but it looked like they did the sign extend thing for every int but
file descriptors, and fd's are the only int's we have.

	Robert Love


