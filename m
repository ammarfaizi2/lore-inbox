Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQLKNVS>; Mon, 11 Dec 2000 08:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130425AbQLKNVI>; Mon, 11 Dec 2000 08:21:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64780 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129511AbQLKNUv>; Mon, 11 Dec 2000 08:20:51 -0500
Subject: Re: INIT_LIST_HEAD marco audit
To: mhaque@haque.net (Mohammad A. Haque)
Date: Mon, 11 Dec 2000 12:52:28 +0000 (GMT)
Cc: miles@megapathdsl.net (Miles Lane), fdavis112@juno.com (Frank Davis),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A3454BE.352FDB96@haque.net> from "Mohammad A. Haque" at Dec 10, 2000 11:14:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145SRT-0007sM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -static struct tq_struct tcic_task = {
> -	routine:	tcic_bh
> +DECLARE_TASK_QUEUE(tcic_task);
> +struct tq_struct run_tcic_task = {
> +	routine:	(void (*)(void *)) tcic_bh
>  };

Why remove the 'static' ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
