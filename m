Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271067AbTGWAlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 20:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271068AbTGWAlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 20:41:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1933 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271066AbTGWAlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 20:41:12 -0400
Date: Tue, 22 Jul 2003 17:54:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: Otto Solares <solca@guug.org>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-Id: <20030722175400.4fe2aa5d.davem@redhat.com>
In-Reply-To: <20030722182609.GA30174@guug.org>
References: <20030722025142.GC25561@guug.org>
	<20030722080905.A21280@devserv.devel.redhat.com>
	<20030722182609.GA30174@guug.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003 12:26:09 -0600
Otto Solares <solca@guug.org> wrote:

> converting the esp scsi driver to sbus without
> pci requirement is the right step IMO.  Maybe
> the scsi people can comment on this.

No, the problem is that SCSI DMA transfer direction
macros are defined in terms of PCI ones.  That's all,
it's a minor issue and probably easily solved.
