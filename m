Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270563AbRHIT11>; Thu, 9 Aug 2001 15:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270564AbRHIT1R>; Thu, 9 Aug 2001 15:27:17 -0400
Received: from netsonic.fi ([194.29.192.20]:36114 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S270563AbRHIT1C>;
	Thu, 9 Aug 2001 15:27:02 -0400
Date: Thu, 9 Aug 2001 22:27:10 +0300 (EEST)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: Alan Cox <laughing@shared-source.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.7-ac9 (breaks ATM connect)
In-Reply-To: <Pine.LNX.4.33.0108092210260.31580-100000@nalle.netsonic.fi>
Message-ID: <Pine.LNX.4.33.0108092225440.31580-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Sampsa Ranta wrote:

> -           vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
> +           vci != ATM_VCI_ANY && vci > 1 << dev->ci_range.vci_bits))

 ..

>                     if (c >= 1 << vcc->dev->ci_range.vci_bits)

Pardon me, bugs come in too easy..

-           vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
+           vci != ATM_VCI_ANY && vci >= 1 << dev->ci_range.vci_bits))

 - Sampsa Ranta
   sampsa@netsonic.fi


