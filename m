Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbVLVWIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbVLVWIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVLVWIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:08:13 -0500
Received: from pat.uio.no ([129.240.130.16]:39415 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030341AbVLVWIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:08:12 -0500
Subject: Re: [PATCH] sched: Fix adverse effects of
	NFS	client	on	interactive response
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43AA0EEA.8070205@bigpond.net.au>
References: <43A8EF87.1080108@bigpond.net.au>
	 <1135145341.7910.17.camel@lade.trondhjem.org>
	 <43A8F714.4020406@bigpond.net.au>
	 <1135171280.7958.16.camel@lade.trondhjem.org>
	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>
	 <1135172453.7958.26.camel@lade.trondhjem.org>
	 <43AA0EEA.8070205@bigpond.net.au>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 17:08:02 -0500
Message-Id: <1135289282.9769.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.95, required 12,
	autolearn=disabled, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 13:26 +1100, Peter Williams wrote:

> > Then have io_schedule() automatically set that flag, and convert NFS to
> > use io_schedule(), or something along those lines. I don't want a bunch
> > of RT-specific flags littering the NFS/RPC code.
> 
> This flag isn't RT-specific.  It's used in the scheduling SCHED_NORMAL 
> tasks and has no other semantic effects.

It still has sod all business being in the NFS code. We don't touch task
scheduling in the filesystem code.

  Trond

