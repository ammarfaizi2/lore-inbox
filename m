Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSJ1BUU>; Sun, 27 Oct 2002 20:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSJ1BUU>; Sun, 27 Oct 2002 20:20:20 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:64396 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262803AbSJ1BUT>; Sun, 27 Oct 2002 20:20:19 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 27 Oct 2002 17:35:58 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Hugh Dickins <hugh@veritas.com>, mingming cao <cmm@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]updated ipc lock patch 
In-Reply-To: <20021028011720.7662B2C099@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210271734450.7252-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Rusty Russell wrote:

> +struct ipc_rcu_kmalloc
> +{
> +	struct rcu_head rcu;
> +	/* "void *" makes sure alignment of following data is sane. */
> +	void *data[0];
> +};

Rusty, why not using gcc "aligned" keywords instead of black magic :

void *data[0];



- Davide


