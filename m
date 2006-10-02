Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWJBR0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWJBR0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWJBR0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:26:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2486 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965157AbWJBR0f
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:26:35 -0400
Subject: Re: Postal 56% waits for flock_lock_file_wait
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Tim Chen <tim.c.chen@intel.com>,
       "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
In-Reply-To: <1159809081.5466.3.camel@lade.trondhjem.org>
References: <B41635854730A14CA71C92B36EC22AAC3AD954@mssmsx411>
	 <1159723092.5645.14.camel@lade.trondhjem.org>
	 <3282373b0610020957u739392eekf8b78c7574e1a6e7@mail.gmail.com>
	 <1159809081.5466.3.camel@lade.trondhjem.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 18:51:56 +0100
Message-Id: <1159811516.8907.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-02 am 13:11 -0400, ysgrifennodd Trond Myklebust:
> Ext3 does not use flock() in order to lock its journal. The performance
> issues that he is seeing may well be due to the journalling, but that
> has nothing to do with flock_lock_file_wait.

The ext3 journal also generally speaking improves many-writer
performance as do the reservations so the claim seems odd on that basis
too. Rerun the test on a gigabyte iRam or similar and you'll see where
the non-media bottlenecks actually are

