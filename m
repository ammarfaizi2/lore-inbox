Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTFIKtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTFIKtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:49:22 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:48044 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262818AbTFIKtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:49:21 -0400
Message-Id: <200306091102.h59B2wsG020791@ginger.cmf.nrl.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] assorted changes to atm protocol stack 
In-reply-to: Your message of "Sun, 08 Jun 2003 21:51:21 EDT."
             <200306090151.h591pLC07310@relax.cmf.nrl.navy.mil> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 09 Jun 2003 07:01:06 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	vcc->local = *addr;
> 	vcc->reply = WAITING;
>-	add_wait_queue(&vcc->sleep,&wait);
>-	sigd_enq(vcc,as_bind,NULL,NULL,&vcc->local);
>+	add_wait_queue(&vcc->sleep, &wait);
>+	sigd_enq(vcc, as_bind, NULL, NULL, &vcc->local);
> 	while (vcc->reply == WAITING && sigd) {
> 		set_current_state(TASK_UNINTERRUPTIBLE);
> 		schedule();
> 	}
>-	remove_wait_queue(&vcc->sleep,&wait);

forgot to ask but i imagine that the add_wait_queue() and remove_wait_queue()
should probably be converted to prepare_to_wait() and finish_wait()?
