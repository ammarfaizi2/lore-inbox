Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268670AbUJPLJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268670AbUJPLJw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 07:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268697AbUJPLJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 07:09:52 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:4103 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268670AbUJPLJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 07:09:49 -0400
Date: Sat, 16 Oct 2004 12:09:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: schwidefsky@de.ibm.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Patch to add RAID autostart to IBM partitions
Message-ID: <20041016110939.GB30336@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pete Zaitcev <zaitcev@redhat.com>, schwidefsky@de.ibm.com,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20041015224822.7d980a9e@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015224822.7d980a9e@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 10:48:22PM -0700, Pete Zaitcev wrote:
> Hi, guys:
> 
> This is an implementation of essentially the same mechanism which exists
> in msdos.c and sun.c. It is needed when initrd tries to mount a root
> on a RAID. One might ask, why the heck initrd cannot do it without a
> kernel help. The answer is in the contrived API of the MD driver: there
> is no way to ask "assemble md0"; applications must list components.
> Anyway, if msdos.c does it, surely ibm.c ought to do it as well.

We had this for a few partition types (and full block devices) already
and it's been vetoed.  Use mdadm from initrd/initramfs instead.

