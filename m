Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTKTBCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 20:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTKTBCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 20:02:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:6340 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264201AbTKTBCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 20:02:03 -0500
Date: Wed, 19 Nov 2003 17:02:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-Id: <20031119170233.2619ba81.akpm@osdl.org>
In-Reply-To: <20031120002119.GA7875@localhost>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar>
	<20031120002119.GA7875@localhost>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Luis Domingo Lopez <linux-kernel@24x7linux.com> wrote:
>
> PS2: trying to "recompile" vmmon and vmnet again and starting VMware,
> when tried to boot some guest OS I got the following in the logs:
> 
> kernel BUG at mm/memory.c:793!

err, this is due to pagefault-accounting-fix.patch.  Looks like vmware has
its own pagefault handler and Bill didn't update vmware ;)

Bill, can we take those BUGs out of there and just do some sane default
thing?

