Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVGNNI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVGNNI1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVGNNI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:08:27 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:17127
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261354AbVGNNI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:08:26 -0400
Subject: Re: Thread_Id
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, rvk@prodmail.net,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050714123917.GE4884@devserv.devel.redhat.com>
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>
	 <42CB465E.6080104@shaw.ca> <42D5F934.6000603@prodmail.net>
	 <1121327103.3967.14.camel@laptopd505.fenrus.org>
	 <42D63916.7000007@prodmail.net>
	 <1121337052.3967.25.camel@laptopd505.fenrus.org>
	 <42D64A85.7020305@prodmail.net>
	 <1121343943.3967.32.camel@laptopd505.fenrus.org>
	 <20050714123917.GE4884@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 15:08:24 +0200
Message-Id: <1121346504.5104.13.camel@atlas.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And you certainly shouldn't be using gettid () syscall in NPTL, as it 
> is just an implementation detail that there is a 1:1 mapping between 
> NPTL threads and kernel threads.  It can change at any time.

Maybe I missed the point, but I thought the 1:1 mapping between NPTL
threads and kernel threads is one of the advantages of NPTL and the idea
of a userland scheduler is quite dead. 

So please let gettid do what man gettid assures:
gettid  returns the thread ID of the current process. This is equal to
the process ID (as returned by getpid(2)), unless the process is  part
of  a thread group (created by specifying the CLONE_THREAD flag to the
clone(2) system call). All processes in the same thread group have the
same PID, but each one has a unique TID.

Bene

