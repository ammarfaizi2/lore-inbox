Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136240AbREJMzd>; Thu, 10 May 2001 08:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136244AbREJMzY>; Thu, 10 May 2001 08:55:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46607 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136240AbREJMzN>; Thu, 10 May 2001 08:55:13 -0400
Subject: Re: Deadlock in 2.2 sock_alloc_send_skb?
To: Ulrich.Weigand@de.ibm.com
Date: Thu, 10 May 2001 13:57:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        schwidefsky@de.ibm.com
In-Reply-To: <C1256A48.00451BD1.00@d12mta11.de.ibm.com> from "Ulrich.Weigand@de.ibm.com" at May 10, 2001 02:34:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xq0v-0004j0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If that happens, and the socket uses GFP_ATOMIC allocation, the while (1)
> loop in sock_alloc_send_skb() will endlessly spin, without ever calling
> schedule(), and all the time holding the kernel lock ...

If the socket is using GFP_ATOMIC allocation it should never loop. That is
-not-allowed-. 

> Do you agree that this is a problem?  What do you think about this fix:

Looks good

