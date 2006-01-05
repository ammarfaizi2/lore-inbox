Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWAEOVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWAEOVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWAEOVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:21:41 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:9572 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751278AbWAEOVk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:21:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MgupDLnZzJueGvd/x3vmaJMj8NhQalvwgNh/4V1lq3m+6MugkpKwTIYMgpkLsZo5vJ8rlwsvotkpuKMO+ZYkcjdy9wrV8QzvG1LEGtjrNLz1DPyUhwAC5nHq5VDf4J2KWE2YUO58EfQfReIWaC2G/FDMtzgnEBl3ZYwzI8z3rlI=
Message-ID: <39e6f6c70601050621l1a63d061pd91e90035bf79873@mail.gmail.com>
Date: Thu, 5 Jan 2006 12:21:39 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] fix ipvs compilation
Cc: wensong@linux-vs.org, horms@verge.net.au, ja@ssi.bg,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060105135943.GA3831@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105135943.GA3831@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Adrian Bunk <bunk@stusta.de> wrote:
> I don't know which change broke it, but I'm getting the following
> compile error in Linus' tree:
>
> <--  snip  -->
>
> ...
>   CC      net/ipv4/ipvs/ip_vs_sched.o
> net/ipv4/ipvs/ip_vs_sched.c: In function 'ip_vs_sched_getbyname':
> net/ipv4/ipvs/ip_vs_sched.c:110: warning: implicit declaration of function 'local_bh_disable'
> net/ipv4/ipvs/ip_vs_sched.c:124: warning: implicit declaration of function 'local_bh_enable'

Thanks Adrian, its related to some header sanitization work I did.

Acked-by: Arnaldo Carvalho de Melo <acme@mandriva.com>

- Arnaldo
