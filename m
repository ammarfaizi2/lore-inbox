Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbUCNIb2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 03:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbUCNIb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 03:31:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:42118 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263329AbUCNIb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 03:31:27 -0500
Date: Sun, 14 Mar 2004 00:31:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: subodh@btopenworld.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-Id: <20040314003126.5f2ec435.akpm@osdl.org>
In-Reply-To: <7F740D512C7C1046AB53446D37200173FEBA2C@scsmsx402.sc.intel.com>
References: <7F740D512C7C1046AB53446D37200173FEBA2C@scsmsx402.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nakajima, Jun" <jun.nakajima@intel.com> wrote:
>
> I checked and tried several things, and I think CONFIG_PCI_USE_VECTOR is
>  a red herring. 2.6.4-mm1 did boot with CONFIG_PCI_USE_VECTOR = Y or N as
>  long as kernel preemption is disabled. It did not boot regardless of
>  CONFIG_PCI_USE_VECTOR if kernel preemption is enabled. I see the
>  complaints
>    bad: scheduling while atomic!
>  at various spots.

Please delete the spin_unlock_irq(&mapping->tree_lock); five lines from the
end of fs/mpage.c.

I assume Subodh did that, but all we know is that it "doesn't boot".

