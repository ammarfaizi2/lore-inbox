Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVFZGqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVFZGqz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 02:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVFZGqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 02:46:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35716 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261404AbVFZGqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 02:46:50 -0400
Date: Sat, 25 Jun 2005 23:46:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Darryl L. Miles" <darryl@netbauds.net>
Cc: linux-kernel@vger.kernel.org, Christian Trefzer <ctrefzer@web.de>,
       Martin Wilck <martin.wilck@fujitsu-siemens.com>
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
Message-Id: <20050625234611.118b391d.akpm@osdl.org>
In-Reply-To: <42BDFEC2.3030004@netbauds.net>
References: <42BDFEC2.3030004@netbauds.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Darryl L. Miles" <darryl@netbauds.net> wrote:
>
> [ modules getting loaded out-of-order and in parallel from initrd ]
>

On June 7, Martin Wilck reported:

> It turned out to be a problem with Red Hat's nash that didn't check the 
> returned pid in it's wait4() call and thus ended up insmod'ing mutliple 
> modules simultaneously, leading to "Unkown symbol" errors. Yuck, it took 
> me a day figure that out.
> 
> That bug is fixed in redhat's "mkinitrd" package 4.2.0.3-1 and later, 
> but that package is currently only in Fedora's "Development" tree.

I'd like to know what changed in the kernel to make nash's behaviour
change.  Martin, did you work that out?
