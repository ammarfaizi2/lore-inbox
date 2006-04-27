Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWD0TH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWD0TH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWD0TH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:07:58 -0400
Received: from pat.uio.no ([129.240.10.6]:40846 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750868AbWD0TH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:07:57 -0400
Subject: Re: Why the RPC task structure adds a new field "tk_count"?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4ae3c140604271132u1f2db743t20aeb94993938086@mail.gmail.com>
References: <4ae3c140604271132u1f2db743t20aeb94993938086@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 15:07:46 -0400
Message-Id: <1146164866.8101.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.821, required 12,
	autolearn=disabled, AWL 1.18, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 14:32 -0400, Xin Zhao wrote:
> I migrate from 2.6.11 to 2.6.16, but found that a new field tk_count
> was added to the rpc task structure. In function rpc_release_task(), I
> saw the following code:
> 
> 	if (!atomic_dec_and_test(&task->tk_count))
> 		return;
> 
> 
> Looks like a task can be reused or refered multiple times? What's the
> theory behind this? Why do we need this?

It is used in several places in the NFSv4 code.

Cheers,
  Trond

