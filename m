Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUGOH6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUGOH6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 03:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUGOH6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 03:58:40 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:28639 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S266136AbUGOH6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 03:58:38 -0400
Message-ID: <1089878317.40f6392d7e365@imp5-q.free.fr>
Date: Thu, 15 Jul 2004 09:58:37 +0200
From: christophe.varoqui@free.fr
To: arjanv@redhat.com, dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] don't allow tmpfs to page out
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> just do 
> mount -t ramfs none /mnt/point
> 
Would that be a suitable solution to store callout binaries for daemons like
multipathd that need to work in case of system-disk outage (/bin & swap on SAN
for example) ?

If so, is it possible and/or correct for the daemon to do a private ramfs mount
for this purpose ?

And while I'm at throwing all the questions I have on my mind :
* how can I disable on-demand loading for the daemon ?
* does mlockall() provides all the necessary garanties ?
* what explains the "offset-by-4" between VSZ and RSS I see when running
mlockall'ed daemon ?

Thanks for the educational work :)

regards,
cvaroqui
