Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTEMWLB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTEMWJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:09:52 -0400
Received: from corky.net ([212.150.53.130]:24265 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S263624AbTEMWJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:09:15 -0400
Date: Wed, 14 May 2003 01:21:56 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: 76306.1226@compuserve.com, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <03051316261500.20373@tabby>
Message-ID: <Pine.LNX.4.44.0305140109160.20904-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Jesse Pollard wrote:

> Though part of it has to do with large systems and crash. What is done
> on some of these systems is to periodically checkpoint batch jobs. If the
> kernel crashes, the job has a physical memory failure, a cpu dies (one out
> of many...) the system resumes processing (after reboot, or removing the
> memory page from the valid list ... whatever recovery method) to then
> reload/resume the processes.
>
> If the random key is lost due to a crash, then reload/resume fails.
>

I thought checkpointing usually takes the whole virtual memory of the
process, regardless of whats in swap and whats in real memory, in which
case the encrypted swap key is not an issue.  If this isn't the case, I
guess the random key has to be preserved as a part of the checkpointing.
Of course, this beats the whole purpose of encrypted swap unless
checkpointing is done into an encrypted device too.  This device must be
encrypted anyway, regardless of swap, because the whole process image will
be stored there.


