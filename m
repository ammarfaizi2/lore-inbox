Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTEFVRA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTEFVRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:17:00 -0400
Received: from [12.47.58.20] ([12.47.58.20]:20333 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262038AbTEFVRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:17:00 -0400
Date: Tue, 6 May 2003 14:25:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@muc.de>
Cc: ak@muc.de, bunk@fs.tum.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix .altinstructions linking failures
Message-Id: <20030506142551.1f5619d6.akpm@digeo.com>
In-Reply-To: <20030506210831.GA18315@averell>
References: <20030506063055.GA15424@averell>
	<20030506164441.GO9794@fs.tum.de>
	<20030506195614.GA23831@averell>
	<20030506210831.GA18315@averell>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 21:29:26.0168 (UTC) FILETIME=[91A26180:01C31416]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Tue, May 06, 2003 at 09:56:14PM +0200, Andi Kleen wrote:
> > The driver is buggy. The #ifdef MODULE needs to be removed and proc_cpia_destroy 
> > be marked __exit instead, then things will be ok.
> 
> FWIW I compiled a "maxi kernel" now (with everything that compiles compiled in) 
> and only cpia seems to have this bug. So with this patch things should be ok
> again.

Where should we be discarding .exit.data?  link-time or runtime?
