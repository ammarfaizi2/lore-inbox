Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVJZTk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVJZTk0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVJZTk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:40:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51941 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964889AbVJZTkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:40:25 -0400
Subject: Re: "Badness in local_bh_enable" - a reasonable fix?
From: Arjan van de Ven <arjan@infradead.org>
To: Steve Snyder <R00020C@freescale.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200510261534.38291.R00020C@freescale.com>
References: <200510261534.38291.R00020C@freescale.com>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 21:40:10 +0200
Message-Id: <1130355615.3339.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 15:34 -0400, Steve Snyder wrote:
> [ I observed the following on a Fedora Core 3 system, running kernel 
> 2.6.12-1.1380_FC3.  I am posting this here because a quick Googling 
> indicates that the problem is not specific to this environment.  ] 
> 
> Today I found my system log filled with the error shown below.  
> Reading a 366MB file across a NFS mount results in over 6300 
> occurrences of the error being written to the system log of the NFS 
> server.  
> 
> I have 2 network interfaces in the NFS server machine, a standard 
> kernel Ethernet device driver and my own Ultra-Wide Band (UWB) device 
> driver.  (In the error shown below the references to "fsuwbpci" are my 
> driver.) This problem is not seen when using the Ethernet interface, 
> but is perfectly consistent when reading a NFS-mounted file across the 
> UWB interface.  Therefore there is a problem with my code.  
> 
> I quickly established that the error came from within this routine:
> 

> -------------------------------------------
> 
> kernel: Badness in local_bh_enable at kernel/softirq.c:140 (Tainted: P     )



hmmm binary module? please try without.

