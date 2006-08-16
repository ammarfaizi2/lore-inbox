Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWHPAIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWHPAIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 20:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWHPAIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 20:08:42 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3558 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750708AbWHPAIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 20:08:42 -0400
Subject: Re: Maximum number of processes in Linux
From: Lee Revell <rlrevell@joe-job.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Irfan Habib <irfan.habib@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <44E254E4.6090508@shaw.ca>
References: <fa.evUDdOgjejpeNWKvgan3aKFF880@ifi.uio.no>
	 <44E254E4.6090508@shaw.ca>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 20:04:36 -0400
Message-Id: <1155686677.2910.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 17:12 -0600, Robert Hancock wrote:
> Irfan Habib wrote:
> > Hi,
> > 
> > What is the maximum number of process which can run simultaneously in
> > linux? I need to create an application which requires 40,000 threads.
> > I was testing with far fewer numbers than that, I was getting
> > exceptions in pthread_create
> 
> What architecture is this? On a 32-bit architecture with a 2MB stack 
> size (which I think is the default) you couldn't possibly create more 
> than 2048 threads just because of stack space requirements. Reducing the 
> stack size would get you more.
> 
> I should also point out that any design that requires 40,000 threads is 
> probably quite flawed unless you are running on a very large machine..
> 

Thread stack size defaults to whatever your distro sets RLIMIT_STACK to.
It's 8MB here.

Lee

