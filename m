Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUI2A4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUI2A4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 20:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUI2AzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 20:55:22 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:17545 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268127AbUI2AxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 20:53:20 -0400
Subject: Re: [PATCH] Use msleep_interruptible for therm_adt7467.c kernel
	thread
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mdz@canonical.com
In-Reply-To: <20040927102552.GA19183@gondor.apana.org.au>
References: <20040927102552.GA19183@gondor.apana.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096289501.9930.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Sep 2004 13:51:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-27 at 11:25, Herbert Xu wrote:
> The continue is just paranoia in case something relies on the sleep
> to take 2 seconds or more.

If the signal occurs then you'll spin for 2 seconds because the signal
is still waiting to be serviced. This therefore looks broken

A more interesting question is why this isn't being driven off a
timer ?

