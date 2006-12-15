Return-Path: <linux-kernel-owner+w=401wt.eu-S1753394AbWLOUOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbWLOUOO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbWLOUOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:14:14 -0500
Received: from outmx008.isp.belgacom.be ([195.238.5.235]:56948 "EHLO
	outmx008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392AbWLOUON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:14:13 -0500
Message-ID: <458301B7.5080609@246tNt.com>
Date: Fri, 15 Dec 2006 21:12:39 +0100
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: tglx@linutronix.de
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] genirq: fix irq flow handler uninstall
References: <1166181714.29505.171.camel@localhost.localdomain>
In-Reply-To: <1166181714.29505.171.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> The sanity check for no_irq_chip in __set_irq_hander() is unconditional
> on both install and uninstall of an handler. This triggers false
> warnings and replaces no_irq_chip by dummy_irq_chip in the uninstall
> case. 
>
> Check only, when a real handler is installed.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>   
Acked-by: Sylvain Munaut <tnt@246tNt.com>


Definitly fixed the spurious warning.

    Sylvain
