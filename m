Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbVLWHyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbVLWHyx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 02:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbVLWHyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 02:54:53 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:24718 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030454AbVLWHyx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 02:54:53 -0500
Date: Fri, 23 Dec 2005 07:54:52 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: liyu <liyu@ccoss.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [WTF?] sys_tas() on m32r
Message-ID: <20051223075452.GS27946@ftp.linux.org.uk>
References: <20051223061556.GR27946@ftp.linux.org.uk> <43ABAC48.20004@ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ABAC48.20004@ccoss.com.cn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 03:50:32PM +0800, liyu wrote:
> >in arch/m32r/kernel/sys_m32r.c.  Trivial oops *AND* ability to trigger
> >IO with interrupts disabled.

> The memory that parameter addr pointer is in user-space.
> To access these memory, you should use function like copy_from_user().

... which is deadly with interrupts disabled/under a spinlock.  Exactly.
