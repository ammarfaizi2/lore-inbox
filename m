Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264181AbRFFVp6>; Wed, 6 Jun 2001 17:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264182AbRFFVps>; Wed, 6 Jun 2001 17:45:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49936 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264181AbRFFVph>; Wed, 6 Jun 2001 17:45:37 -0400
Subject: Re: Linux 2.4.5-ac9
To: t.sailer@alumni.ethz.ch
Date: Wed, 6 Jun 2001 22:43:31 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3B1DF4BC.6A8C5CBC@scs.ch> from "Thomas Sailer" at Jun 06, 2001 11:15:40 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157l5P-0000VT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks bogus. Independent processes can open the same device
> once for reading and once for writing, now you are serializing
> needlessly these processes. Please revert.

Some of the serializing is not a bug but I agree that patch is not yet
right. Think for example about


		thread1			thread2

	write
		blocks			 mmap

Also parallel buffer allocations 

Alan

