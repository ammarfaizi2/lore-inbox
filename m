Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269755AbUINTsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269755AbUINTsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbUINTph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:45:37 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:46860 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269494AbUINToG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:44:06 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: root@chaos.analogic.com, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Kernel stack overflow on 2.6.9-rc2
Date: Tue, 14 Sep 2004 22:43:55 +0300
User-Agent: KMail/1.5.4
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, netdev@oss.sgi.com
References: <200409141723.35009.vda@port.imtp.ilyichevsk.odessa.ua> <20040914163347.GE3197@schnapps.adilger.int> <Pine.LNX.4.53.0409141340540.4262@chaos>
In-Reply-To: <Pine.LNX.4.53.0409141340540.4262@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409142243.55949.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 September 2004 20:55, Richard B. Johnson wrote:
> Has anybody ever explained why there is an attempt to
> minimize the size of the kernel stack? Temporary data
> allocation on the stack is FREE! The compiler just
> adjusts offsets for data. Even dynamic data-allocation
> takes only one instruction, (subl %reg, %esp).

IIRC it is done in order to be able to support large number
of threads on 32-bit machines and to avoid needing to do
a order-1 allocation at fork().
--
vda

