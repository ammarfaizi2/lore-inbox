Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVEINcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVEINcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 09:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVEINcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 09:32:42 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:58894 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261369AbVEINck convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 09:32:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L8QPtMPKneNakwu47GzSS+zgAP6+xqmnnYLx16hvYbTafeaid+TF9BJXpNfE0I5xaV1M5B1jU+xtqO6jT9NtjHo8g6144Yk0TJ0ep9JSldTtbZqCD6HD1v62tAk1Y1pkxFQvmdSrE1JoVHHj2VQk2VxeC6ekzD9zIMtNtoZIlQ0=
Message-ID: <9cde8bff0505090632550f3d9e@mail.gmail.com>
Date: Mon, 9 May 2005 06:32:38 -0700
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@engr.sgi.com>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Alexander Nyberg <alexn@dsv.su.se>
In-Reply-To: <1115644436.8540.83.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
	 <1115644436.8540.83.camel@frecb000711.frec.bull.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/05, Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> ChangeLog:
> 
>   - Replace the GFP_ATOMIC flag in cn_netlink_send() by
>     GFP_KERNEL|__GFP_NOFAIL
>   - Move the following code
>         #ifdef CONFIG_FORK_CONNECTOR
>         static DEFINE_PER_CPU(unsigned long, fork_counts);
>         #endif /* CONFIG_FORK_CONNECTOR */
>     in the driver/connector/cn_fork.c file.
>   - Remove the code of fork_connector() from the header file
>     and put it in cn_fork.c

this is a good idea, because it will shrink your modification to
mainline kernel by few more lines ;-)

regards,
aq
