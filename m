Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264461AbRFOROi>; Fri, 15 Jun 2001 13:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264463AbRFORO2>; Fri, 15 Jun 2001 13:14:28 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:33540 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264461AbRFOROO>; Fri, 15 Jun 2001 13:14:14 -0400
Date: Fri, 15 Jun 2001 14:05:25 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Petko Manolov <pmanolov@Lnxw.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmalloc
Message-ID: <20010615140525.A960@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Petko Manolov <pmanolov@Lnxw.COM>, linux-kernel@vger.kernel.org
In-Reply-To: <3B2A3F90.799ACAC4@lnxw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B2A3F90.799ACAC4@lnxw.com>; from pmanolov@Lnxw.COM on Fri, Jun 15, 2001 at 10:02:08AM -0700
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 15, 2001 at 10:02:08AM -0700, Petko Manolov escreveu:
> 	Hi there,
> 
> AFAIK there was similar discusion almos a year
> ago but i can't remember the details.
> 
> kmalloc fails to allocate more than 128KB of
> memory regardless of the flags (GFP_KERNEL/USER/ATOMIC)
> 
> Any ideas?
> 
> I am not quite sure if this is the expected behavior.

yes, expected behaviour, at most you can allocate 32 contiguous pages with
kmalloc, if you need more and it is not for DMA, use vmalloc, that will not
try to use contiguous pages

- Arnaldo
