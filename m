Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUFJGS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUFJGS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUFJGS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:18:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:5292 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263204AbUFJGS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:18:56 -0400
Date: Wed, 9 Jun 2004 23:18:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5: Device-mapper: kcopyd
Message-Id: <20040609231805.029672aa.akpm@osdl.org>
In-Reply-To: <20040602154129.GO6302@agk.surrey.redhat.com>
References: <20040602154129.GO6302@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
> kcopyd
> 
> ...
> +/* FIXME: this should scale with the number of pages */
> +#define MIN_JOBS 512

This pins at least 2MB of RAM up-front, even if devicemapper is not in use.

Have you any plans to fix that up?
