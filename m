Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264203AbRFMTfm>; Wed, 13 Jun 2001 15:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264218AbRFMTfc>; Wed, 13 Jun 2001 15:35:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:64006 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264203AbRFMTfY>; Wed, 13 Jun 2001 15:35:24 -0400
Date: Wed, 13 Jun 2001 16:35:10 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: dipi_k@123india.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: net_device list in kernel
Message-ID: <20010613163510.P941@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	dipi_k@123india.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010613191418.17176.cpmta@c009.snv.cp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010613191418.17176.cpmta@c009.snv.cp.net>; from dipi_k@123india.com on Wed, Jun 13, 2001 at 12:14:18PM -0700
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 13, 2001 at 12:14:18PM -0700, dipi_k@123india.com escreveu:
> 
> Hi,
>   
>  I have one doubt.
> 
>   There is a list of the devices(net_device{} structures) maintained in kernel which has all the interfaces initialised by that time. This list is refrenced by dev_base variable.
> 
>  I need following info
> 
> 1) does kernel maintain a global variable which keeps the count of net_device{} in above list?

not that I'm aware
 
> 2) Is this list modified(net_device{} added or deleted ) once it's initialised at boot time?

Yes, think about loading a module for a network card, it will add one entry
(or more in some cases) to this list, or think about net aliases. Look at
register_netdevice in net/core/dev.c
 
- Arnaldo
