Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTKJEIk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 23:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTKJEIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 23:08:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:39871 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262844AbTKJEIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 23:08:39 -0500
Date: Sun, 9 Nov 2003 20:12:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: arief_mulya <arief_m_utama@telkomsel.co.id>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH?] psmouse-base.c
Message-Id: <20031109201211.2ce2edce.akpm@osdl.org>
In-Reply-To: <3FAEF7BC.8060503@telkomsel.co.id>
References: <3FAEF7BC.8060503@telkomsel.co.id>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arief_mulya <arief_m_utama@telkomsel.co.id> wrote:
>
> static int psmouse_pm_callback(struct pm_dev *dev, pm_request_t request, 
>  void *data)
>  {
>          struct psmouse *psmouse = dev->data;
>          struct serio_dev *ser_dev = psmouse->serio->dev;
>                                                                                 
>   
>          switch (request) {
>          case PM_RESUME:
>                  psmouse->state = PSMOUSE_IGNORE;
>                  serio_rescan(psmouse->serio);
>          default:
>                  return 0;
>          }
>  }

What does the driver do without this change?  ie: what problem is this
fixing?

Why is it calling serio_rescan() rather than serio_reconnect()?

