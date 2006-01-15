Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWAOXC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWAOXC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 18:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWAOXC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 18:02:56 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:29900 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S1750963AbWAOXCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 18:02:55 -0500
Message-ID: <43CAD4FA.9090702@f2s.com>
Date: Sun, 15 Jan 2006 23:04:26 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] arm26: kernel/irq.c: fix compilation
References: <20060114224043.GA9982@mipter.zuzino.mipt.ru>
In-Reply-To: <20060114224043.GA9982@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> It's trying to "continue;" in "if" statement.

This ones been submitted before - guess it never made it.

Thanks!

Signed-off-by: Ian Molton <spyro@f2s.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

  arch/arm26/kernel/irq.c |    3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm26/kernel/irq.c
+++ b/arch/arm26/kernel/irq.c
@@ -141,7 +141,7 @@ int show_interrupts(struct seq_file *p,
  	if (i < NR_IRQS) {
  	    	action = irq_desc[i].action;
  		if (!action)
-			continue;
+			goto out;
  		seq_printf(p, "%3d: %10u ", i, kstat_irqs(i));
  		seq_printf(p, "  %s", action->name);
  		for (action = action->next; action; action = action->next) {
@@ -152,6 +152,7 @@ int show_interrupts(struct seq_file *p,
  		show_fiq_list(p, v);
  		seq_printf(p, "Err: %10lu\n", irq_err_count);
  	}
+out:
  	return 0;
  }




