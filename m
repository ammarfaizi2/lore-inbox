Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWDYFJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWDYFJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 01:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWDYFJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 01:09:23 -0400
Received: from pat.uio.no ([129.240.10.6]:54948 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751387AbWDYFJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 01:09:23 -0400
Subject: Re: question about nfs_execute_read: why do we need to do
	lock_kernel?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4ae3c140604242157k26f39f71qcf6eed811f1e2d8@mail.gmail.com>
References: <4ae3c140604242157k26f39f71qcf6eed811f1e2d8@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 01:09:03 -0400
Message-Id: <1145941743.8164.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.13, required 12,
	autolearn=disabled, AWL 1.68, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 00:57 -0400, Xin Zhao wrote:
> This question may be dumb. But I am curious why in nfs_execute_read()
> function, rpc_execute  is bracketed with lock_kernel() and
> unlock_kernel()?

We're keeping the BKL for the moment simply because we are not done
auditing all the RPC code for potential races. When that is done, we
will be able to remove it.

Cheers,
  Trond

