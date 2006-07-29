Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752051AbWG2CC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbWG2CC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbWG2CC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:02:26 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:52901 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1752051AbWG2CCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:02:25 -0400
Message-ID: <44CAC1AF.6010505@oracle.com>
Date: Fri, 28 Jul 2006 19:02:23 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC][PATCH] Fix lock inversion aio_kick_handler()
References: <20060729001032.GA7885@tetsuo.zabbo.net> <20060729013446.GA3387@kvack.org>
In-Reply-To: <20060729013446.GA3387@kvack.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Fri, Jul 28, 2006 at 05:10:32PM -0700, Zach Brown wrote:
>> Fix lock inversion aio_kick_handler()
> 
> Doh.  Unfortunately, this patch isn't entirely correct as it could race with 
> __put_ioctx() which sets ioctx->mm = NULL.

Aha, yeah, that's what I was missing.  Thanks.

> Something like the following should do the trick:

Cool, I'll respin and send it out.

- z
