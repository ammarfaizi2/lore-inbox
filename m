Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbVKCD5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbVKCD5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbVKCD5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:57:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751587AbVKCD5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:57:48 -0500
Date: Thu, 3 Nov 2005 13:57:35 +1100
From: Andrew Morton <akpm@osdl.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Manu Abraham <manu@linuxtv.org>
Subject: Re: [PATCH 24/37] dvb: dst: protect the read/write commands with a
 mutex
Message-Id: <20051103135735.6d860a73.akpm@osdl.org>
In-Reply-To: <4367240C.8030204@m1k.net>
References: <4367240C.8030204@m1k.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
> +	sema_init(&state->dst_mutex, 1);

We normally use init_MUTEX(), so we don't have to remember that 1 == unlocked.
