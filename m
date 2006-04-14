Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWDNANz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWDNANz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWDNANz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:13:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965031AbWDNANy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:13:54 -0400
Date: Thu, 13 Apr 2006 17:13:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, clameter@sgi.com, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 2/5] Swapless V2: Add migration swap entries
Message-Id: <20060413171331.1752e21f.akpm@osdl.org>
In-Reply-To: <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	<20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> +
>  +	if (unlikely(is_migration_entry(entry))) {

Perhaps put the unlikely() in is_migration_entry()?

>  +		yield();

Please, no yielding.

_especially_ no unchangelogged, uncommented yielding.

>  +		goto out;
>  +	}
>  +
