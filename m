Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbRFFKwW>; Wed, 6 Jun 2001 06:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbRFFKwM>; Wed, 6 Jun 2001 06:52:12 -0400
Received: from ns.caldera.de ([212.34.180.1]:35508 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261617AbRFFKwA>;
	Wed, 6 Jun 2001 06:52:00 -0400
Date: Wed, 6 Jun 2001 12:51:51 +0200
Message-Id: <200106061051.f56App623652@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: laughing@shared-source.org (Alan Cox)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac9
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010605234928.A28971@lightning.swansea.linux.org.uk>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010605234928.A28971@lightning.swansea.linux.org.uk> you wrote:
> 2.4.5-ac9

> o	Add es1371 sound driver locking			(Frank Davis)

It's buggy.  The locking in ->read and ->write will give
double ups when a signal is pending and remove a not added waitq
when programming the dmabuf fails.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
