Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbVKPUsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbVKPUsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVKPUsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:48:19 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:20411 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030470AbVKPUsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:48:19 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com
In-Reply-To: <20051116203603.GA12505@elf.ucw.cz>
References: <20051114212341.724084000@sergelap>
	 <20051114153649.75e265e7.pj@sgi.com>
	 <20051115055107.GB3252@IBM-BWN8ZTBWAO1>
	 <20051113152214.GC2193@spitz.ucw.cz>
	 <9901B851-17B2-4AEB-813F-A92560DFE289@mac.com>
	 <20051116203603.GA12505@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 21:48:10 +0100
Message-Id: <1132174090.5937.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 21:36 +0100, Pavel Machek wrote:
> Hmm... it is hard to judge a patch without context. Anyway, can't we
> get process snasphot/resume without virtualizing pids? Could we switch
> to 128-bits so that pids are never reused or something like that?

That might work fine for a managed cluster, but it wouldn't be a good
fit if you ever wanted to support something like a laptop in
disconnected operation, or if you ever want to restore the same snapshot
more than once.  There may also be some practical userspace issues
making pids that large.

I also hate bloating types and making them sparse just for the hell of
it.  It is seriously demoralizing to do a ps and see
7011827128432950176177290 staring back at you. :)

-- Dave

