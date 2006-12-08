Return-Path: <linux-kernel-owner+w=401wt.eu-S1947321AbWLHVjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947321AbWLHVjj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947319AbWLHVji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:39:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40333 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947317AbWLHVji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:39:38 -0500
Date: Fri, 8 Dec 2006 13:38:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Shirish S Pargaonkar <shirishp@us.ibm.com>, simo <simo@samba.org>,
       Jeremy Allison <jra@samba.org>, linux-cifs-client@lists.samba.org
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061208133849.fabfa683.akpm@osdl.org>
In-Reply-To: <4579AFA5.90003@us.ibm.com>
References: <4579AFA5.90003@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 12:32:05 -0600
Steve French <smfltc@us.ibm.com> wrote:

> akpm wrote:
> >deprecate-smbfs-in-favour-of-cifs.patch
> >deprecate-smbfs-in-favour-of-cifs-docs.patch
> >
> > Am still waiting to hear from sfrench on the appropriateness of this.
> 
> 
> smbfs deprecation is ok but there are a few things to consider:

OK, thanks for the update.  We would like to make smbfs go away asap, but
from my POV it's up to you to say when we should do that.

otoh, it might be a good idea to merge a variant of that patch which
doesn't mention a specific data.  Say,

	if (warn_count < 5) {
		warn_count++;
		printk(KERN_EMERG "smbfs is not being maintained."
			" Please migrate to cifs\n");
	}

?

> 
> ...
>
> Running simple tests on smbfs, I run into so many problems now though, it
> is probably time to mark it as deprecated as Fedora etc. apparently 
> already have.

No, smbfs is not in very good shape.


