Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264769AbTE1Pbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbTE1Pbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:31:49 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:26633 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264769AbTE1Pbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:31:48 -0400
Date: Wed, 28 May 2003 19:44:27 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Two patches - ptrace single stepping + modpost.c
Message-ID: <20030528194427.A16019@jurassic.park.msu.ru>
References: <20030528125853.A30380@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030528125853.A30380@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, May 28, 2003 at 12:58:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 12:58:53PM +0100, Russell King wrote:
> Other architectures which use similar schemes (eg, alpha) might also
> like this; it looks like Alpha may be a little buggy; it appears
> to carry the single stepping status across signal handling.  What
> happens if the debugger decides to disable single stepping when
> the debugged process receives a signal?

Alpha was buggy, indeed. Hopefully fixed in current bk.
However, we don't need special flag for single stepping - we use
thread_info->bpt_nsaved as such flag.

Ivan.
