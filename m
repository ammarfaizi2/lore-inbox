Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTGWJYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 05:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTGWJYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 05:24:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30096 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263152AbTGWJYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 05:24:41 -0400
Date: Wed, 23 Jul 2003 02:37:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: "C.Newport" <crn@netunix.com>
Cc: solca@guug.org, hch@infradead.org, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-Id: <20030723023720.1a98b541.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0307231031240.26107-100000@hek.netunix.com>
References: <20030723012824.5d8dec9b.davem@redhat.com>
	<Pine.LNX.4.33.0307231031240.26107-100000@hek.netunix.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 10:35:56 +0100 (BST)
"C.Newport" <crn@netunix.com> wrote:

> In that case none, but your original message implied that this did
> not exist and would not be supported.
> 
> Maybe I misunderstood what you meant.
> 
> OTOH, (if !SBUS) might screw up ?.

Look, SBUS does _NOT_ use the generic device abstraction.
Therefore all SBUS drivers call into the sbus_* DMA operations
directly.

Everything just works, as it always has, and it's not going to break
any time soon.

What I'm saying is that I'm not going to move the SBUS layer
over to use generic devices.
