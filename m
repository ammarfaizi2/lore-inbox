Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311404AbSCMWXF>; Wed, 13 Mar 2002 17:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311405AbSCMWWz>; Wed, 13 Mar 2002 17:22:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9224 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311404AbSCMWWo>; Wed, 13 Mar 2002 17:22:44 -0500
Subject: Re: 2.5.6: ide driver broken in PIO mode
To: akpm@zip.com.au (Andrew Morton)
Date: Wed, 13 Mar 2002 22:37:33 +0000 (GMT)
Cc: andre@linux-ide.org (Andre Hedrick),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3C8FB15B.67953DDD@zip.com.au> from "Andrew Morton" at Mar 13, 2002 12:06:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lHNF-0007eO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> b) The block layer needs to be extended so the driver can walk
>    all the request's segments prior to signalling completion
>    against any of them.

This would be good - batching blocks by peeking down the queue is good
for raid cards which tend to want stripe sized chunks
