Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTEFCAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTEFCAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:00:00 -0400
Received: from [12.47.58.20] ([12.47.58.20]:11524 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262254AbTEFB77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 21:59:59 -0400
Date: Mon, 5 May 2003 19:14:09 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@muc.de>
Cc: gj@pointblue.com.pl, bunk@fs.tum.de, linux-kernel@vger.kernel.org,
       ak@muc.de, ingo.oeser@informatik.tu-chemnitz.de
Subject: Re: 2.5.68-bk11: .text.exit errors in .altinstructions
Message-Id: <20030505191409.2e2a265c.akpm@digeo.com>
In-Reply-To: <20030506005326.GB18146@averell>
References: <20030502171355.GU21168@fs.tum.de>
	<1052175893.25085.9.camel@nalesnik>
	<20030506005326.GB18146@averell>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 02:12:25.0824 (UTC) FILETIME=[EFE28600:01C31374]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Tue, May 06, 2003 at 01:04:55AM +0200, Grzegorz Jaskiewicz wrote:
> > I've got the same problem with 2.5.69:
> 
> Use the same workaround. Remove .text.exit from the DISCARD
> section in your vmlinux.lds.S
> 
> Really the problem is unfixable without binutils changes in other
> ways, sorry.

How's about we drop .text.exit at runtime, along with .text.init?


