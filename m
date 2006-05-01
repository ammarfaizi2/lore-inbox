Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWEAJMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWEAJMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 05:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWEAJMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 05:12:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13281 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751229AbWEAJMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 05:12:31 -0400
Date: Mon, 1 May 2006 02:07:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
Message-Id: <20060501020722.62bc5050.akpm@osdl.org>
In-Reply-To: <20060501085939.GV3570@stusta.de>
References: <20060501071134.GH3570@stusta.de>
	<20060501001803.48ac34df.akpm@osdl.org>
	<20060501073514.GQ3570@stusta.de>
	<1146469146.20760.31.camel@laptopd505.fenrus.org>
	<20060501004925.36e4dd21.akpm@osdl.org>
	<20060501085939.GV3570@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> So the work would expand to:
>  - writing 200 feature-removal-schedule.txt entries
>  - marking 200 functions and variables as __deprecated_for_modules
>
>  And in a few months:
>  - removing 200 feature-removal-schedule.txt entries
>  - removing 200 __deprecated_for_modules markers
>  - removing the 200 unused exports

Don't bother with all that stuff - a modprobe-time warning across a few
kernel releases is sufficient to make any developers who are dependent upon
an export aware of their problem.

Changing the export to EXPORT_UNUSED_SYMBOL() and then later removing the
export is adequate.
