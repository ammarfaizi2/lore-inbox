Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVAIJg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVAIJg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 04:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVAIJg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 04:36:29 -0500
Received: from postman.fhs-hagenberg.ac.at ([193.170.124.96]:21944 "EHLO
	postman.fhs-hagenberg.ac.at") by vger.kernel.org with ESMTP
	id S262030AbVAIJgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 04:36:23 -0500
Date: Sun, 9 Jan 2005 10:36:18 +0100
From: Clemens Buchacher <drizzd@aon.at>
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [7/7] LEON SPARC V8 processor support for linux-2.6.10
Message-ID: <20050109093618.GA25465@kzelldran.lan>
Mail-Followup-To: Jiri Gaisler <jiri@gaisler.com>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <41DAE8CC.3010904@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DAE8CC.3010904@gaisler.com>
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 09 Jan 2005 09:36:13.0283 (UTC) FILETIME=[A8B8D330:01C4F62E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 08:04:44PM +0100, Jiri Gaisler wrote:
> +static irqreturn_t leonuart_int(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct uart_port *port = dev_id;
> +	unsigned int status;
> +
> +	spin_lock(port ->lock);

I think that should be

	spin_lock(&port->lock);

[...]
> +	spin_unlock(port ->lock);

and

	spin_unlock(&port->lock);

> +	return IRQ_HANDLED;
> +}

	Regards,
	Clemens
