Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbSLJWT4>; Tue, 10 Dec 2002 17:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbSLJWTz>; Tue, 10 Dec 2002 17:19:55 -0500
Received: from [66.70.28.20] ([66.70.28.20]:57348 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266851AbSLJWTw>; Tue, 10 Dec 2002 17:19:52 -0500
Date: Tue, 10 Dec 2002 23:28:42 +0100
From: DervishD <raul@pleyades.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [BK-2.4] [PATCH] Small do_mmap_pgoff correction
Message-ID: <20021210222842.GA64@DervishD>
References: <20021210205906.GA82@DervishD> <20021210.132207.23687680.davem@redhat.com> <20021210221357.GA46@DervishD> <20021210.141451.66294590.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021210.141451.66294590.davem@redhat.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi David :)

> How about something like:
> 
> 	if (len == 0)
> 		return addr;
> 
> 	len = PAGE_ALIGN(len);
> 	if (len > TASK_SIZE || len == 0)
> 		return -EINVAL;
> 
> That should cover all cases and not make the TASK_SIZE assumption.

    Perfect :) If you want, I can make the patch and tell to Alan and
Linus. Anyway, I think you will better heared than me O:))

    Anyway, I'll take a look at a new macro (lets say PAGE_ALIGN_SIZE
or something as ugly as this ;)))

    Thanks for your correction.

    Raúl
