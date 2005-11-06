Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVKFU6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVKFU6Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 15:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVKFU6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 15:58:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750883AbVKFU6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 15:58:24 -0500
Date: Sun, 6 Nov 2005 12:57:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, ak@suse.de, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH 3/5] cpuset: change marker for relative numbering
Message-Id: <20051106125738.7e140f1c.akpm@osdl.org>
In-Reply-To: <20051106020410.2c0c26e1.pj@sgi.com>
References: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
	<20051104053132.549.16062.sendpatchset@jackhammer.engr.sgi.com>
	<20051104230827.16001781.akpm@osdl.org>
	<20051106020410.2c0c26e1.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> > Given that you're developing a library to do all this, why not do proper
>  > locking in userspace and require that all cpuset updates go via the
>  > library?
> 
>  The superficial reason why not is that I can't prevent someone from
>  doing "echo pid > /dev/cpuset/tasks", moving a task to another cpuset
>  even as that task in the middle of dorking with its cpusets.  Not all
>  cpuset operations will involve using my blessed library.

If someone modifies a library-managed cpuset via the backdoor then the
library (and its caller) are out of sync with reality _anyway_.  Why does
an encounter with this very small race window worsen things?
