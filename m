Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317276AbSGTAfe>; Fri, 19 Jul 2002 20:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317278AbSGTAfe>; Fri, 19 Jul 2002 20:35:34 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20759 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317276AbSGTAfe>; Fri, 19 Jul 2002 20:35:34 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200207200038.g6K0cZO12086@devserv.devel.redhat.com>
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
To: eggert@twinsun.com (Paul Eggert)
Date: Fri, 19 Jul 2002 20:38:35 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, rms@gnu.org, alan@redhat.com (Alan Cox)
In-Reply-To: <200207190952.g6J9q4I07044@sic.twinsun.com> from "Paul Eggert" at Jul 19, 2002 02:52:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <http://www.opengroup.org/onlinepubs/007904975/functions/select.html>
> says that 'select' may modify its timeout argument only "upon
> successful completion".  However, the Linux kernel sometimes modifies
> the timeout argument even when 'select' fails or is interrupted.

This is extremely useful behaviour. POSIX is broken here. Fix it in the
C library or somewhere it doesn't harm the clueful

You should raise this with the standards committee instead
