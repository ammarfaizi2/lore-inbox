Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269801AbUJSQp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269801AbUJSQp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269760AbUJSQgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:36:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11983 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269719AbUJSQdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:33:19 -0400
Date: Tue, 19 Oct 2004 09:32:37 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: Patch to add RAID autostart to IBM partitions
Message-ID: <20041019093237.291b7ab8@lembas.zaitcev.lan>
In-Reply-To: <16756.29638.846336.56357@cse.unsw.edu.au>
References: <20041015224822.7d980a9e@lembas.zaitcev.lan>
	<20041016110939.GB30336@infradead.org>
	<20041016082937.62c15e6c@lembas.zaitcev.lan>
	<16756.29638.846336.56357@cse.unsw.edu.au>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.7; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 11:54:14 +1000, Neil Brown <neilb@cse.unsw.edu.au> wrote:

Dear Neil,

thank you for your patient reply. It makes things a lot clearer.

> Yes, you haven't told it what defines "/dev/md0", so it assumes the
> first device listed will define it, but /dev/dasda doesn't so....

> You have to tell mdadm how to recognise /dev/md0.  Possibly by UUID.
> Possibly by "minor number".
> e.g.
> 
>  DEVICE partitions
>  ARRAY /dev/md0 super-minor=0
> 
> which means "if you find any devices listed in /proc/partitions which
> contains an MD superblock which has a "md_minor" field of "0", then
> use those to assemble /dev/md0.

I see now. I'm sorry that I was unable to deduce it from the manual.
One last question, if the -As worked, would it do the same?

> This will often be what you want, but might not always.  e.g. if you
> have plugged in a drive that was part of /dev/md0 in another machine,
> then mdadm will have no way of knowing which drive is the "right" one.

I guess there's nothing we can do about possible conflicts, except warn
the operator at installation time. What is the recommended way to ask
mdadm to list all conflicts, or simply all found array devices, for the
benefit of an installation program reading a pipe?

-- Pete
