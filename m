Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbTBYRU5>; Tue, 25 Feb 2003 12:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268093AbTBYRU5>; Tue, 25 Feb 2003 12:20:57 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3716
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267937AbTBYRU4>; Tue, 25 Feb 2003 12:20:56 -0500
Subject: Re: check cpu_online() in nr_running()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030225163335.GD10396@holomorphy.com>
References: <20030225163335.GD10396@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046197963.4055.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 25 Feb 2003 18:32:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-25 at 16:33, William Lee Irwin III wrote:
>  	for (i = 0; i < NR_CPUS; i++)
> +		if (!cpu_online(i))
> +			continue;
>  		sum += cpu_rq(i)->nr_running;

I smell donkey poo 8)

If the change is right, which seems reasonable then I think you
need some { } 's too. Its also a hot path so it may be a lot
cleaner to keep the jump out of this by just letting
nr_running be zero for other processors ?

