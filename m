Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266176AbUGOKAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUGOKAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 06:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbUGOKAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 06:00:51 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:35201 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S266176AbUGOKAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 06:00:36 -0400
Message-ID: <1089885635.40f655c34efef@imp5-q.free.fr>
Date: Thu, 15 Jul 2004 12:00:35 +0200
From: christophe.varoqui@free.fr
To: Arjan van de Ven <arjanv@redhat.com>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Q] don't allow tmpfs to page out
References: <1089878317.40f6392d7e365@imp5-q.free.fr> <20040715080017.GB20889@devserv.devel.redhat.com>
In-Reply-To: <20040715080017.GB20889@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Arjan van de Ven <arjanv@redhat.com>:

> 
> On Thu, Jul 15, 2004 at 09:58:37AM +0200, christophe.varoqui@free.fr wrote:
> > > 
> > > just do 
> > > mount -t ramfs none /mnt/point
> > > 
> > Would that be a suitable solution to store callout binaries for daemons
> like
> > multipathd that need to work in case of system-disk outage (/bin & swap on
> SAN
> > for example) ?
> 
> somewhat, as long as ALL requirements are there, including all libraries ;)
> 
ok, sure.
klibc linked static binaries in my case (scsi_id & multipath), so it should be ok.

> > If so, is it possible and/or correct for the daemon to do a private ramfs
> mount
> > for this purpose ?
> 
> sure; namespaces can do a LOT

Somehow "man 2 mount" is not so verbose about that "lot" :)
Can you feed a pointer to a doc explaining how to achieve such privacy ?

> > 
> > And while I'm at throwing all the questions I have on my mind :
> > * how can I disable on-demand loading for the daemon ?
> > * does mlockall() provides all the necessary garanties ?
> 
> mlockall does not guarantee that syscalls you do don't cause memory
> allocations, nor does the ramfs approach.
> 
mmm ... more questions than I had before :)
any hint about how to solve this issue ?

regards,
cvaroqui


-- 
