Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278684AbRJSWWu>; Fri, 19 Oct 2001 18:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278683AbRJSWWj>; Fri, 19 Oct 2001 18:22:39 -0400
Received: from t2.redhat.com ([199.183.24.243]:51452 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S278684AbRJSWWX>; Fri, 19 Oct 2001 18:22:23 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3BD092A6.26A1CFE9@zip.com.au> 
In-Reply-To: <3BD092A6.26A1CFE9@zip.com.au> 
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, David Hinds <dhinds@sonic.net>
Subject: Re: [patch] ip autoconfig for PCMCIA NICs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Oct 2001 23:22:46 +0100
Message-ID: <29471.1003530166@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


akpm@zip.com.au said:
>  Also, yenta_open() currently defers device initialisation to keventd,
> so there is a good chance that cardbus init hasn't completed by the
> time we hit ip autoconf, so the yenta_open_bh functionality is made
> synchronous.

That was async at Linus' request - if we register the irq early, some 
boards die in an interrupt storm. Linux is currently fairly crap at 
noticing and recovering from interrupt storms.


--
dwmw2


