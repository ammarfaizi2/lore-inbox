Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268697AbUJDXbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268697AbUJDXbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 19:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUJDXbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 19:31:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:62641 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268697AbUJDXbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 19:31:39 -0400
Date: Mon, 4 Oct 2004 16:35:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Phil Oester <kernel@linuxace.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Process start times moving in reverse on 2.6.8.1
Message-Id: <20041004163511.5624c52c.akpm@osdl.org>
In-Reply-To: <20041004190054.GA29409@linuxace.com>
References: <20041004190054.GA29409@linuxace.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester <kernel@linuxace.com> wrote:
>
> ISTR discussion on the mailing list about this problem,
> and recently upgraded from 2.6.3 to 2.6.8.1 to hopefully
> solve it, but alas the problem still exists.
> 
> Example:
> 
> # date ; ps -ef | grep ps | grep -v grep
> Mon Oct  4 14:53:39 EDT 2004
> root     29412 29351  0 14:51 pts/0    00:00:00 ps -ef
> 
> Notice the two minute difference between now and what the
> process start time is.  Uptime on this box is 48 days, so
> it is a gradual drift.
> 
> Any ideas on this?  Or has it been fixed since 2.6.8.1?

It's allegedly fixed by
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/broken-out/fix-process-start-times.patch
but I've seen no confirmation of that.

