Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbTENMxq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbTENMxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:53:46 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:7675 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262112AbTENMxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:53:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Yoav Weiss <ml-lkml@unpatched.org>
Subject: Re: The disappearing sys_call_table export.
Date: Wed, 14 May 2003 08:05:25 -0500
X-Mailer: KMail [version 1.2]
Cc: 76306.1226@compuserve.com, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305140109160.20904-100000@marcellos.corky.net>
In-Reply-To: <Pine.LNX.4.44.0305140109160.20904-100000@marcellos.corky.net>
MIME-Version: 1.0
Message-Id: <03051408052500.22500@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 May 2003 17:21, Yoav Weiss wrote:
> On Tue, 13 May 2003, Jesse Pollard wrote:
> > Though part of it has to do with large systems and crash. What is done
> > on some of these systems is to periodically checkpoint batch jobs. If the
> > kernel crashes, the job has a physical memory failure, a cpu dies (one
> > out of many...) the system resumes processing (after reboot, or removing
> > the memory page from the valid list ... whatever recovery method) to then
> > reload/resume the processes.
> >
> > If the random key is lost due to a crash, then reload/resume fails.
>
> I thought checkpointing usually takes the whole virtual memory of the
> process, regardless of whats in swap and whats in real memory, in which
> case the encrypted swap key is not an issue.  If this isn't the case, I
> guess the random key has to be preserved as a part of the checkpointing.
> Of course, this beats the whole purpose of encrypted swap unless
> checkpointing is done into an encrypted device too.  This device must be
> encrypted anyway, regardless of swap, because the whole process image will
> be stored there.

Depends on the system - I believe Cray used to have the option of 
checkpointing to the swap device since otherwise the system would be 
oversubscribed and subject to deadlock hangs. Other configurations will
exactly what you said, and have the same problems that swap does.
