Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbTBDOsE>; Tue, 4 Feb 2003 09:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTBDOsE>; Tue, 4 Feb 2003 09:48:04 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:33201 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267273AbTBDOsD> convert rfc822-to-8bit; Tue, 4 Feb 2003 09:48:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Axel Kittenberger <Axel.Kittenberger@maxxio.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: oom_kill
Date: Tue, 4 Feb 2003 08:55:14 -0600
User-Agent: KMail/1.4.1
Cc: riel@nl.linux.org
References: <200302041332.05096.Axel.Kittenberger@maxxio.com> <200302040807.03214.pollard@admin.navo.hpc.mil> <200302041513.29093.Axel.Kittenberger@maxxio.com>
In-Reply-To: <200302041513.29093.Axel.Kittenberger@maxxio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302040855.14469.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 February 2003 08:13 am, Axel Kittenberger wrote:
> > And what about processes that get reparented to init? These could be
> > causing the OOM. I didn't think that the p_ptr was null when reparenting
> > happens.
>
> Okay good, should we use the "original parent" instead?

I'm not familiar enough with the reparenting to know. I'm not sure you can 
tell the difference.

> Yes, I'm not absolutly not sure if the != NULL expression is necessary,
> Don't know enough about the task structering for this. I tried without and
> the machine at least didn't crash, but just wanted to be safe.

I was considering that a possible test for a reparented process since the
original parent doesn't necessarily exist anymore, though it would make
more sense to have that point to init, than point to anything else.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
