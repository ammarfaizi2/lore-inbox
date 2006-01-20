Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWATWwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWATWwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWATWwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:52:42 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:28369 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932259AbWATWwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:52:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=UuKHx5hghDb7OaTmJExRn5ZN86yqPR3i2Pab3pSnE4mVJMZBSShBwjEjeU6SX0FBTRjMVtFQJU/7z7SrQGvT+pCeLWyGwlPQj8XwANtJ0Q2amSne5DuArmy20q1uETRFsahMNVLzZ5u4/5Vlk1+H1W1EOQFtLJvdOAqIBZHAh1o=
Date: Sat, 21 Jan 2006 02:10:05 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/serial/sh-sci.c: add forgotten {
Message-ID: <20060120231005.GA3511@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Watch for next l4x.org run to find out if it works. ;-)
 Specifically, section "h8300".

 drivers/serial/sh-sci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -646,19 +646,19 @@ static inline int sci_handle_errors(stru
 }
 
 static inline int sci_handle_breaks(struct uart_port *port)
 {
 	int copied = 0;
 	unsigned short status = sci_in(port, SCxSR);
 	struct tty_struct *tty = port->info->tty;
 	struct sci_port *s = &sci_ports[port->line];
 
-	if (!s->break_flag && status & SCxSR_BRK(port))
+	if (!s->break_flag && status & SCxSR_BRK(port)) {
 #if defined(CONFIG_CPU_SH3)
 		/* Debounce break */
 		s->break_flag = 1;
 #endif
 		/* Notify of BREAK */
 		if(tty_insert_flip_char(tty, 0, TTY_BREAK))
 			copied++;
 		pr_debug("sci: BREAK detected\n");
 	}

