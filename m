Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291270AbSBLXT4>; Tue, 12 Feb 2002 18:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291258AbSBLXQy>; Tue, 12 Feb 2002 18:16:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34578 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291259AbSBLXPp>; Tue, 12 Feb 2002 18:15:45 -0500
Subject: Re: [PATCH] 2.4.18-pre9, trylock for read/write semaphores
To: bwatson@kahuna.cag.cpqcorp.net
Date: Tue, 12 Feb 2002 23:29:29 +0000 (GMT)
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, hch@caldera.de
In-Reply-To: <200202122257.g1CMv9W05368@kahuna.cag.cpqcorp.net> from "bwatson@kahuna.cag.cpqcorp.net" at Feb 12, 2002 02:45:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16amMb-0003RQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	new = old + RWSEM_ACTIVE_READ_BIAS;
> +	if (cmpxchg(&sem->count, old, new) == old)
> +		return 1;

cmpxchg isnt present on i386

