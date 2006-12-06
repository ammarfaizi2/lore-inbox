Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936100AbWLFQMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936100AbWLFQMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936250AbWLFQMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:12:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38406 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936100AbWLFQMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:12:13 -0500
Date: Wed, 6 Dec 2006 08:12:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH]: cpu hotplug locking fix
Message-Id: <20061206081201.9fafe733.akpm@osdl.org>
In-Reply-To: <20061206160429.6419.27617.sendpatchset@prarit.boston.redhat.com>
References: <20061206160429.6419.27617.sendpatchset@prarit.boston.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 11:04:29 -0500
Prarit Bhargava <prarit@redhat.com> wrote:

> --- linux-2.6.18.ia64/kernel/cpu.c.orig	2006-10-31 10:57:37.000000000 -0500
> +++ linux-2.6.18.ia64/kernel/cpu.c	2006-10-31 10:57:46.000000000 -0500
> @@ -58,8 +58,8 @@ void unlock_cpu_hotplug(void)
>  		recursive_depth--;
>  		return;
>  	}
> -	mutex_unlock(&cpu_bitmask_lock);
>  	recursive = NULL;
> +	mutex_unlock(&cpu_bitmask_lock);
>  }

That's already in 2.6.19.
