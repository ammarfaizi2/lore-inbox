Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbRFFLrT>; Wed, 6 Jun 2001 07:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbRFFLrA>; Wed, 6 Jun 2001 07:47:00 -0400
Received: from mail.scs.ch ([212.254.229.5]:46344 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S262242AbRFFLqs>;
	Wed, 6 Jun 2001 07:46:48 -0400
Message-ID: <3B1E16EB.9FEA94CA@scs.ch>
Date: Wed, 06 Jun 2001 13:41:31 +0200
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
CC: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac9
In-Reply-To: <200106061051.f56App623652@ns.caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig schrieb:
> 
> In article <20010605234928.A28971@lightning.swansea.linux.org.uk> you wrote:
> > 2.4.5-ac9
> 
> > o     Add es1371 sound driver locking                 (Frank Davis)
> 
> It's buggy.  The locking in ->read and ->write will give
> double ups when a signal is pending and remove a not added waitq
> when programming the dmabuf fails.

But Alan added a different patch than yours, that doesn't
seem to have poll in the guard.

Also, both your and Frank Davis' patch don't care about dac, which
seems bogus to me.

Tom
