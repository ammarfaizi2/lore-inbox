Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317516AbSFMI1B>; Thu, 13 Jun 2002 04:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317513AbSFMI1A>; Thu, 13 Jun 2002 04:27:00 -0400
Received: from mail.webmaster.com ([216.152.64.131]:15020 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317492AbSFMI07> convert rfc822-to-8bit; Thu, 13 Jun 2002 04:26:59 -0400
From: David Schwartz <davids@webmaster.com>
To: <kernel@tekno-soft.it>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Thu, 13 Jun 2002 01:26:58 -0700
In-Reply-To: <5.1.1.6.0.20020613095304.00a6fc60@mail.tekno-soft.it>
Subject: Re: Developing multi-threading applications
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020613082659.AAA17584@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jun 2002 10:13:35 +0200, Roberto Fichera wrote:

>I'm designing a multithreding application with many threads,
>from ~100 to 300/400. I need to take some decisions about
>which threading library use, and which patch I need for the
>kernel to improve the scheduler performances. The machines
>will be a SMP Xeon with 4/8 processors with 4Gb RAM.
>All threads are almost computational intensive and the library
>need a fast interprocess comunication and syncronization
>because there are many sync & async threads time
>dependent and/or critical. I'm planning, in the future, to distribuite
>all the threads in a pool of SMP box.

	With 4/8 processors, you don't want to create 100-400 threads doing 
computation intensive tasks. So redesign things so that the number of threads 
you create is more in line with the number of CPUs you have available. That 
is, use a 'thread per CPU' (or slightly more threads than their are CPUs per 
node) approach and you'll perform a lot better. Distribute the available work 
over the available threads.

	DS


