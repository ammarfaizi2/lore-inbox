Return-Path: <linux-kernel-owner+w=401wt.eu-S932111AbXAIOkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbXAIOkW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 09:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbXAIOkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 09:40:22 -0500
Received: from main.gmane.org ([80.91.229.2]:56929 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbXAIOkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 09:40:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: pierre Tardy <tardyp@gmail.com>
Subject: Re: [RFC] New MMC driver model
Date: Tue, 9 Jan 2007 14:25:37 +0000 (UTC)
Message-ID: <loom.20070109T150821-717@post.gmane.org>
References: <449553E5.9030004@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.88.166.35 (Mozilla/5.0 (X11; U; Linux i686; fr; rv:1.8.1.1) Gecko/20061208 Firefox/2.0.0.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list <at> drzeus.cx> writes:

>
> Register functions
> ==================
> 
> I also intend to write a couple of register functions (sdio_read[bwl])
> so that card drivers doesn't have to deal with MMC requests more than
> necessary.

Good idea. Another need may be a sdio_read[bwl]_sync, which will poll for the
end of the cmd52s, instead of waiting for the irq. This polling is faster than
wait_for_completion/irq/tasklet/complete mechanism, which involve several
context switches. 

>  Endianness can also be handled there (SDIO are always LE).
I dont remember sdio spec forcing HW registers to be LE. Function 0 registers
are (BLKSZ for ex), but Function 1-7 register may be BE if the designers found
an advantage to it..




