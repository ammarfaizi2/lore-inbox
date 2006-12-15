Return-Path: <linux-kernel-owner+w=401wt.eu-S964928AbWLOVCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWLOVCJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWLOVCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:02:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44398 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964928AbWLOVCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:02:07 -0500
Date: Fri, 15 Dec 2006 13:01:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Damien Wyart <damien.wyart@free.fr>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       Jeff Garzik <jeff@garzik.org>, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.20-rc1-mm1
Message-Id: <20061215130141.fd6a0c25.akpm@osdl.org>
In-Reply-To: <20061215203936.GA2202@localhost.localdomain>
References: <20061214225913.3338f677.akpm@osdl.org>
	<20061215203936.GA2202@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 21:39:36 +0100
Damien Wyart <damien.wyart@free.fr> wrote:

> With this new kernel, I notice two messages I do not have with
> 2.6.19-rc6-mm2 :
> 
> Dec 15 20:00:47 brouette kernel: Filesystem "sdb9": Disabling barriers,trial barrier write failed
> Dec 15 20:00:47 brouette kernel: Filesystem "sda5": Disabling barriers,trial barrier write failed
> 
> Nothing changed in the config between the two, and going back to
> 2.6.19-rc6-mm2 do not give the messages.

I don't think anything has changed in this area in XFS.  I'd expect that
something got broken in sata, ata_piix or the block core which caused the
"trial barrier write" to start failing.  Various cc's hopefully added.

> Also, I got panics when unmounting reiser4 filesystems with
> 2.6.20-rc1-mm1 but I guess this is related to your waring about reiser4
> being broken in 2.6.19-mm1 (even if it is not listed in notes for
> 2.6.20-rc1-mm1)... I attach dmesg and config, but the reiser4 panics did
> not get logged and I am not able to reboot on 2.6.20-rc1-mm1 right now.
> For the moment, I mainly wanted to report the xfs messages which seems
> a bit suspect.

The reiser4 failure is unexpected.  Could you please see if you can capture
a trae, let the people at reiserfs-dev@namesys.com know?

Thanks.
