Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263874AbUDNExN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 00:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbUDNExN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 00:53:13 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:36534 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263874AbUDNExM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 00:53:12 -0400
Message-ID: <407CC3AB.6050602@colorfullife.com>
Date: Wed, 14 Apr 2004 06:52:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: Fw: [PATCH] Fix mq_notify with SIGEV_NONE notification
References: <20040413163605.031af36c.akpm@osdl.org>
In-Reply-To: <20040413163605.031af36c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

Jakub wrote:

>mq_notify (q, NULL)
>and
>struct sigevent ev = { .sigev_notify = SIGEV_NONE };
>mq_notify (q, &ev)
>are not the same thing in POSIX, yet the kernel treats them the same.
>
What should mq_notify(q, &{.sigev_notify = SIGEV_NONE}) do? Register a 
notification, but deliver nothing?

--
    Manfred

