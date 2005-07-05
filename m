Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVGENBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVGENBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 09:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVGENBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 09:01:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33672 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261836AbVGEMzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 08:55:54 -0400
Subject: Re: Thread_Id
From: Arjan van de Ven <arjan@infradead.org>
To: rvk@prodmail.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42CA79DE.9060701@prodmail.net>
References: <20050723150209.GA15055@krispykreme>
	 <42CA79DE.9060701@prodmail.net>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 14:55:42 +0200
Message-Id: <1120568143.3180.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-05 at 17:45 +0530, RVK wrote:
> Can anyone suggest me how to get the threadId using 2.6.x kernels. 
> pthread_self() does not work and returns some -ve integer.

NAME
       pthread_self - get the calling thread ID

SYNOPSIS
       #include <pthread.h>

       pthread_t pthread_self(void);

DESCRIPTION
       The pthread_self() function shall return the thread ID of the
calling thread.




pthread_self() works just fine for me. But... what makes you think a
"negative" value is a failure? What interpretation are you giving to
thread ID that negative woudl be wrong? A pthreads thread ID is just a
cookie you only can use to give back to the pthread library functions in
places where it's needed...


