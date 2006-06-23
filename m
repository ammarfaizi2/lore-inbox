Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWFWCya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWFWCya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 22:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWFWCya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 22:54:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28313 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750968AbWFWCya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 22:54:30 -0400
Date: Thu, 22 Jun 2006 19:54:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, jeremy@goop.org,
       rdunlap@xenotime.net, clameter@sgi.com, ntl@pobox.com,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] avoid cpu removal if busy revisited
Message-Id: <20060622195409.1ea44604.akpm@osdl.org>
In-Reply-To: <20060623105058.96937576.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060623105058.96937576.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 10:50:58 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> +static int test_cpu_busy(int cpu)
> ...
> +		if (moderate_cpu_removal && test_cpu_bust(cpu))

I love the function name but alas, the linker will not.

Let's treat this as an [rfc].  Please test the final version carefully.
