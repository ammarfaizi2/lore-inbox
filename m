Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbRFFJVZ>; Wed, 6 Jun 2001 05:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbRFFJVP>; Wed, 6 Jun 2001 05:21:15 -0400
Received: from mail.scs.ch ([212.254.229.5]:7944 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S261385AbRFFJVC>;
	Wed, 6 Jun 2001 05:21:02 -0400
Message-ID: <3B1DF4BC.6A8C5CBC@scs.ch>
Date: Wed, 06 Jun 2001 11:15:40 +0200
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac9
In-Reply-To: <20010605234928.A28971@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox schrieb:

> 2.4.5-ac9
> o       Add es1371 sound driver locking                 (Frank Davis)

Looks bogus. Independent processes can open the same device
once for reading and once for writing, now you are serializing
needlessly these processes. Please revert.

Tom
