Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWAWV0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWAWV0f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWAWV0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:26:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964867AbWAWV0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:26:34 -0500
Date: Mon, 23 Jan 2006 13:25:54 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: david-b@pacbell.net, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: EHCI + APIC errors = no usb goodness
Message-Id: <20060123132554.13411a1d.zaitcev@redhat.com>
In-Reply-To: <20060123210443.GA20944@suse.de>
References: <20060123210443.GA20944@suse.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006 13:04:43 -0800, Greg KH <gregkh@suse.de> wrote:

> Now I'm down to the last problem, USB doesn't work, which is a bit of a
> pain for me :)

> [   87.406180] APIC error on CPU0: 00(40)
> [   87.426282] drivers/usb/core/inode.c: creating file '001'
> [   87.426333] hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0000
> [   87.712002] APIC error on CPU0: 40(40)
> [   87.774743] irq 16: nobody cared (try booting with the "irqpoll" option)

Why do you even enable APIC on an old laptop? We tried it a few times,
it's just not possible. I'd say, about one in ten to one in five of 2002
vintage laptops will not even boot, let alone work when APIC is enabled.
Some of them are well known, like Dell Lattitude 610. I expect this to
change with dual-core laptops, but for now the rule is: UP kernel,
No APIC, for distro kernels at least.

-- Pete
