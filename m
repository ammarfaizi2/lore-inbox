Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSFUHbs>; Fri, 21 Jun 2002 03:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSFUHbs>; Fri, 21 Jun 2002 03:31:48 -0400
Received: from mail.spylog.com ([194.67.35.220]:42467 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S316434AbSFUHbq>;
	Fri, 21 Jun 2002 03:31:46 -0400
Date: Fri, 21 Jun 2002 11:31:40 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre10aa4 & Intel EtherExpress driver "e100".
Message-ID: <20020621073140.GA30147@spylog.ru>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	lkml <linux-kernel@vger.kernel.org>
References: <20020620170047.GB1134@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020620170047.GB1134@dualathlon.random>
User-Agent: Mutt/1.4i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

1. My hardware:

M/B Intel STL2:
	- ServerWorks ServerSet III LE chipset).
  - Integrated on-board Intel EtherExpress PRO100+ 10/100mbit PCI controller
    (Intel 82559)


2. Problem:

2.4.19pre10aa3 - load kernel & driver ok, work.
...
Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 1.8.38                      Copyright (c) 2002 Intel Corporation                                                                       
eth0: Intel(R) 8255x-based Ethernet Adapter                                           
Mem:0xfb101000  IRQ:18  Speed:100 Mbps  Dx:Full
Hardware receive checksums enabled cpu cycle saver enabled                                
...


2.4.19pre10aa4 :
....
Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 2.0.30-k1
Copyright (c) 2002 Intel Corporation

hw init failed
Failed to initialize e100, instance #0
....


Whay?



> This fixes a mistake from my part in task_rq_lock and integrates the
> latest version of e100 e1000 per jam's suggestion, it works again on
> alpha (was a tux compile trouble).
> 
> URL:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa4.gz
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa4/
> 
> Only in 2.4.19pre10aa4: 00_e100-2.0.30-k1.gz
> Only in 2.4.19pre10aa4: 00_e1000-4.2.17-k1.gz
> Only in 2.4.19pre10aa3: 07_e100-1.8.38.gz
> Only in 2.4.19pre10aa3: 08_e100-includes-1
> Only in 2.4.19pre10aa3: 09_e100-compilehack-1
> 
> 	e100 and e1000 from 2.4.19pre10jam2.
> 
> Only in 2.4.19pre10aa3: 20_o1-sched-updates-A4-1
> Only in 2.4.19pre10aa4: 20_o1-sched-updates-A4-2
> 
> 	Cleanup alpha and fix lock_rq_task.
> 
> Only in 2.4.19pre10aa4: 61_tux-alpha-compile-1
> 
> 	Fix compile problem with tux on alpha.
> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
bye.
Andrey Nekrasov, SpyLOG.
