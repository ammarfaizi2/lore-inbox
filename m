Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWDMS3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWDMS3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWDMS3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:29:12 -0400
Received: from smtp-out-01.utu.fi ([130.232.202.171]:25021 "EHLO
	smtp-out-01.utu.fi") by vger.kernel.org with ESMTP id S964798AbWDMS3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:29:11 -0400
Date: Thu, 13 Apr 2006 21:29:10 +0300
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: select takes too much time
In-reply-to: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Message-id: <200604132129.10056.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 18:01, Ram Gupta wrote:
> I am using select with a timeout value of 90 ms. But for some reason
> occasionally  it comes out of select after more than one second .

I have a memory-starved prosignia that sometimes needs up to
10 seconds :)
Though that includes bringing in the relevant code page of the userspace
application too, and that page probably gets discarded after doing the
syscall, or similar.
It's all allright though, it gets served eventually.

> I 
> checked the man page but it does not help in concluding if this is ok
> or not.

The documentation doesn't impose or guarantee any minimum performance,
as far as I know.
