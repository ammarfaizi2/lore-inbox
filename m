Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbUJXT6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUJXT6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 15:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbUJXT6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 15:58:05 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:40162 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261241AbUJXT6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 15:58:00 -0400
Subject: Re: [PATCH] SCSI: Replace semaphores with wait_even
From: James Bottomley <James.Bottomley@SteelEye.com>
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <1098300579.20821.65.camel@thomas>
References: <1098300579.20821.65.camel@thomas>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Oct 2004 15:57:43 -0400
Message-Id: <1098647869.10824.247.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 15:29, Thomas Gleixner wrote:
> 
> Use wait_event instead of semaphores. Semaphores are slower
> and trigger owner conflicts during semaphore debugging.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Ingo Molnar <mingo@elte.hu>
> ---

There's something deeply wrong with this.  It causes a boot hang in my
scsi test systems.

James


