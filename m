Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVBIOpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVBIOpM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 09:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVBIOpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 09:45:12 -0500
Received: from village.ehouse.ru ([193.111.92.18]:9741 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261828AbVBIOpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 09:45:05 -0500
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc3-bk5: XFS: fcron: could not write() buf to disk: Resource temporarily unavailable
Date: Wed, 9 Feb 2005 17:44:54 +0300
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200502082051.36989.gluk@php4.ru> <20050209012900.GA1140@frodo>
In-Reply-To: <20050209012900.GA1140@frodo>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502091744.55137.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 February 2005 04:29, Nathan Scott wrote:
> On Tue, Feb 08, 2005 at 08:51:36PM +0300, Alexander Y. Fomichev wrote:
> > G' day
> >
> > It looks like XFS broken somewhere in 2.6.11-rc1,
> > sadly i can't sand "right" bugreport, some facts only.
> > Upgrade to 2.6.11-rc2 makes fcron non-working for me in case of
> > crontabs directory is placed on XFS partition.
> > When i try to install new crontab fcrontab die with error:
> > "could not write() buf to disk: Resource temporarily unavailable"
>
> Is that an O_SYNC write, do you know?  Or a write to an inode
> with the sync flag set?

Yes, it is O_SYNC, as i can see from fcron sources, and, no, kernel
have been compiled without xattrs support (if i understand
your question correctly)

>
> > The same time it works with 2.6.10.
>
> I'm chasing down a problem similar to this atm, so far looks like
> something in the generic VM code below sync_page_range is giving
> back EAGAIN, and that is getting passed back out to userspace by
> XFS.  Not sure where/why/how its been caused yet though ... I'll
> let you know once I have a fix or have found the culprit change.
>
> cheers.

Tnx for quick answer.

PS: i forgot to mention last time i tested 2.6.11-rc3-bk5 with the
same results.

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
