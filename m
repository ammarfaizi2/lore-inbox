Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752381AbWCKIWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbWCKIWq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 03:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbWCKIWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 03:22:46 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:52261 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752379AbWCKIWq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 03:22:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iM9SdGfdo642u0oPLNs4IWIsvkg/iC+dVIL4ftenE0oZXXZYODKERnzc7Qeh1l1s7ePaLgDo6m1wc6FdS+WoqswKtJaOJl7mYlLqeEzXXAhANxMTMQ5bD3gg/K92adIUUhtTpNbEwmbRw/Kuowsnif74+k7aTwX60HwGfl5myXc=
Message-ID: <661de9470603110022i25baba63w4a79eb543c5db626@mail.gmail.com>
Date: Sat, 11 Mar 2006 13:52:45 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Nick Piggin" <npiggin@suse.de>
Subject: Re: [patch 1/3] radix tree: RCU lockless read-side
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
In-Reply-To: <20060207021831.10002.84268.sendpatchset@linux.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060207021822.10002.30448.sendpatchset@linux.site>
	 <20060207021831.10002.84268.sendpatchset@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

>                 if (slot->slots[i]) {
> -                       results[nr_found++] = slot->slots[i];
> +                       results[nr_found++] = &slot->slots[i];
>                         if (nr_found == max_items)
>                                 goto out;
>                 }

A quick clarification - Shouldn't accesses to slot->slots[i] above be
protected using rcu_derefence()?

Warm Regards,
Balbir
