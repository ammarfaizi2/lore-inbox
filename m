Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWDREDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWDREDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 00:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWDREDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 00:03:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2743 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751396AbWDREDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 00:03:48 -0400
Date: Mon, 17 Apr 2006 21:03:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.1 & D state processes
Message-Id: <20060417210308.1fadc766.akpm@osdl.org>
In-Reply-To: <20060417234939.28833.qmail@web52601.mail.yahoo.com>
References: <20060417234939.28833.qmail@web52601.mail.yahoo.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au> wrote:
>
> I've reported the same problem on FC5 kernels
>  (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=186856)
>  too, assuming it was an FC only problem. But as it
>  turns out, kernel.org kernels too suffer from this,
>  though it took a while to prove that :(.

Your I/O system has lost some I/O requests: we sent write requests down,
and no completion ever came back.

It could be a broken device driver - please describe the I/O stack.

Or it could be lost interrupts - could be broken platform interrupt setup,
or broken hardware.
