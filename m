Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUJIKvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUJIKvX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 06:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUJIKvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 06:51:23 -0400
Received: from main.gmane.org ([80.91.229.2]:57556 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266687AbUJIKvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 06:51:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Date: Sat, 09 Oct 2004 12:51:02 +0200
Message-ID: <yw1x3c0orwq1.fsf@mru.ath.cx>
References: <41677E4D.1030403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 197.80-202-92.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:3PszU6VGpHd6BDUXRGYG5P3HJY0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven-Thorsten Dietrich <sdietrich@mvista.com> writes:

> +#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
> +/*
> + * This could be a long-held lock.  If another CPU holds it for a long time,
> + * and that CPU is not asked to reschedule then *this* CPU will spin on the
> + * lock for a long time, even if *this* CPU is asked to reschedule.
> + *
> + * So what we do here, in the slow (contended) path is to spin on the lock by
> + * hand while permitting preemption.
> + *
> + * Called inside preempt_disable().
> + */
> +
> +/* these functions are only called from inside spin_lock
> + * and old_write_lock therefore under spinlock substitution
> + * they will only be passed old spinlocks or old rwlocks as parameter
> + * there are no issues with modified mutex behavior here. */
> +
> +#endif /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) */

May I inquire as to the purpose of placing a couple of comments under
an #ifdef?

-- 
Måns Rullgård
mru@mru.ath.cx

