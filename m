Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVGZGSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVGZGSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 02:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVGZGSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 02:18:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261647AbVGZGSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 02:18:37 -0400
Date: Mon, 25 Jul 2005 23:17:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: tmarshall@real.com, pmarques@grupopie.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: itimer oddness in 2.6.12
Message-Id: <20050725231720.507d4b38.akpm@osdl.org>
In-Reply-To: <42E1A208.8060408@mvista.com>
References: <20050722171657.GG4311@real.com>
	<42E14735.1090205@grupopie.com>
	<20050722205825.GB6476@real.com>
	<42E1A208.8060408@mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> +	while (time_before_eq(p->signal->real_timer.expires, jiffies))
> +		p->signal->real_timer.expires += inc;

It gives me the creeps when I see timer code doing this, and it seems to be
done relatively frequently.

Surely it can be calculated arithmetically?  If not, are you really sure
that it is not exploitable by malicious code?
