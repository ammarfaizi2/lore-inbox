Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262265AbSJGAKr>; Sun, 6 Oct 2002 20:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSJGAKr>; Sun, 6 Oct 2002 20:10:47 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:36357 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262265AbSJGAKr>; Sun, 6 Oct 2002 20:10:47 -0400
Date: Sun, 6 Oct 2002 21:16:19 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Carlos E Gorges <carlos@techlinux.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.40 (-ac5) - fix unresolved symbols
Message-ID: <20021007001619.GB18248@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Carlos E Gorges <carlos@techlinux.com.br>,
	linux-kernel@vger.kernel.org
References: <200210021902.35813.carlos@techlinux.com.br> <07ea01c26c2b$7e1e6570$41368490@archaic> <200210062110.27684.carlos@techlinux.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210062110.27684.carlos@techlinux.com.br>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Oct 06, 2002 at 09:10:27PM -0300, Carlos E Gorges escreveu:
> --- linux-2.5.40-ac5/drivers/ieee1394/raw1394.c	Tue Oct  1 04:05:48 2002
> +++ linux-2.5/drivers/ieee1394/raw1394.c	Sun Oct  6 20:55:57 2002
> @@ -786,7 +786,7 @@
>          req->tq.data = req;
>          req->tq.routine = (void (*)(void*))queue_complete_req;
>          req->req.length = 0;
> -        queue_task(&req->tq, &packet->complete_tq);
> +        schedule_task(&req->tq);

Shouldn't INIT_WORK be used?

- Arnaldo
