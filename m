Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135365AbRDLWUH>; Thu, 12 Apr 2001 18:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135364AbRDLWT5>; Thu, 12 Apr 2001 18:19:57 -0400
Received: from t2.redhat.com ([199.183.24.243]:43502 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135363AbRDLWTx>; Thu, 12 Apr 2001 18:19:53 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3AD5F9FE.9A49374D@uow.edu.au> 
In-Reply-To: <3AD5F9FE.9A49374D@uow.edu.au>  <Pine.LNX.4.33.0104121336040.31024-100000@dystopia.lab43.org> 
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Rod Stewart <stewart@dystopia.lab43.org>, linux-kernel@vger.kernel.org,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 8139too: defunct threads 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Apr 2001 23:19:41 +0100
Message-ID: <20905.987113981@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



andrewm@uow.edu.au said:
>  ho-hum.  Jeff, I think the best fix here is to bite the bullet and
> write kernel_daemon(), which will delegate thread creation to keventd,
> which is the only thing we have which reaps zombies.  Any better
> ideas?

Yes. Let init do it, as God intended. Why reap threads in the kernel when 
they could just reparent themselves as children of pid 1?

--
dwmw2


