Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269685AbTHETgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270013AbTHETgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:36:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:23768 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269685AbTHETgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:36:38 -0400
Date: Tue, 5 Aug 2003 12:38:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export touch_nmi_watchdog
Message-Id: <20030805123811.1fe61585.akpm@osdl.org>
In-Reply-To: <20030805192908.GA19867@averell>
References: <20030805192908.GA19867@averell>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> Sometimes drivers do long things with interrupt off and the NMI watchdog
>  triggers quickly. This mostly happens in error handling. It would be 
>  better to fix the drivers to sleep in this case, but it's not always
>  possible or too much work.

yup.

Do we need an mdelay_while_touching_nmi_watchdog() variant?
