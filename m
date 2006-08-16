Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWHPQax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWHPQax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWHPQax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:30:53 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15234 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932100AbWHPQaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:30:52 -0400
Message-ID: <44E34825.2020105@garzik.org>
Date: Wed, 16 Aug 2006 12:30:29 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, James K Lewis <jklewis@us.ibm.com>,
       Arnd Bergmann <arnd@arndb.de>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>, akpm@osdl.org
Subject: Re: [PATCH 1/2]:  powerpc/cell spidernet bottom half
References: <20060811170337.GH10638@austin.ibm.com> <20060816161856.GD20551@austin.ibm.com>
In-Reply-To: <20060816161856.GD20551@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> Please apply and forward upstream. This patch requires the previous
> sequence of 4 spidernet patches to be applied.
> 
> --linas
> 
> 
> The recent set of low-waterark patches for the spider result in a
> significant amount of computing being done in an interrupt context.
> This patch moves this to a "bottom half" aka work queue, so that
> the code runs in a normal kernel context. Curiously, this seems to 
> result in a performance boost of about 5% for large packets.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: Utz Bacher <utz.bacher@de.ibm.com>
> Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>

Let's not reinvented NAPI, shall we...

	Jeff



