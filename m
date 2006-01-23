Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWAWFlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWAWFlg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWAWFlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:41:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964802AbWAWFlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:41:35 -0500
Date: Sun, 22 Jan 2006 21:41:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] device-mapper snapshot: barriers not supported
Message-Id: <20060122214111.11170cdc.akpm@osdl.org>
In-Reply-To: <20060120211759.GG4724@agk.surrey.redhat.com>
References: <20060120211759.GG4724@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
> The snapshot and origin targets are incapable of handling barriers and 
>  need to indicate this.
> 
> ...
>   
>  +	if (unlikely(bio_barrier(bio)))
>  +		return -EOPNOTSUPP;
>  +

And what was happening if people _were_ sending such BIOs down?  Did it all
appear to work correctly?  If so, will this change cause
currently-apparently-working setups to stop working?
