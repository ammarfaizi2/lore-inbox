Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263061AbVCDUwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbVCDUwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbVCDUsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:48:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:13969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263113AbVCDUoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:44:54 -0500
Date: Fri, 4 Mar 2005 12:44:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
Message-Id: <20050304124431.676fd7cf.akpm@osdl.org>
In-Reply-To: <20050304175302.GA29289@kroah.com>
References: <20050304175302.GA29289@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> A few of us $suckers will be trying to maintain a 2.6.x.y set of
>  	releases that happen after 2.6.x is released.

Just to test things out a bit...

Here's the list of things which we might choose to put into 2.6.11.2.  I was
planning on sending them in for 2.6.12 when that was going to be
errata-only.


>From 2.6.11-mm1:

cramfs-small-stat2-fix.patch
setup_per_zone_lowmem_reserve-oops-fix.patch
dv1394-ioctl-retval-fix.patch
ppc32-compilation-fixes-for-ebony-luan-and-ocotea.patch
nfsd--sgi-921857-find-broken-with-nohide-on-nfsv3.patch
nfsd--exportfs-reduce-stack-usage.patch
nfsd--svcrpc-add-a-per-flavor-set_client-method.patch
nfsd--svcrpc-rename-pg_authenticate.patch
nfsd--svcrpc-move-export-table-checks-to-a-per-program-pg_add_client-method.patch
nfsd--nfs4-use-new-pg_set_client-method-to-simplify-nfs4-callback-authentication.patch
nfsd--lockd-dont-try-to-match-callback-requests-against-export-table.patch
audit-mips-fix.patch
make-st-seekable-again.patch

wrt the nfsd patches, Neil said:

The problem they fix is that currently:
    Client A holds a lock
    Client B tries to get the lock and blocks
    Client A drops the lock
  **Client B doesn't get the lock immediately, but has to wait for a
           timeout. (several seconds)


