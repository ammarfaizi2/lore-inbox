Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVKFH5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVKFH5Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 02:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVKFH5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 02:57:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30671 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751215AbVKFH5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 02:57:25 -0500
Subject: Re: SMP CPU affinity questions
From: Arjan van de Ven <arjan@infradead.org>
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: listmonkey@neo.relay-host.net, linux-kernel@vger.kernel.org
In-Reply-To: <4368EBBF.2000302@wolfmountaingroup.com>
References: <20051102175022.13637.qmail@neo.relay-host.net>
	 <4368EBBF.2000302@wolfmountaingroup.com>
Content-Type: text/plain
Date: Sun, 06 Nov 2005 08:56:43 +0100
Message-Id: <1131263804.2826.1.camel@laptopd505.fenrus.org>
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

On Wed, 2005-11-02 at 09:39 -0700, Jeffrey V. Merkey wrote:
> listmonkey@neo.relay-host.net wrote:
> 
> >Hi-
> >
> >I am trying to use a quad Opteron motherboard with SMP Kernel 2.6.5 for a quasi-real-time task.
> >I need to assign all processes to specific CPUs, including interrupt handlers.
> >I have had success using sched_setaffinity() to set the CPU for processes I create, but I am unable,
> >as root, to force system processes to move to another CPU.  Any ideas?
> >
> >I can find no documentation about how to force an interrupt handler to a specific CPU - is this
> >possible without modifying the kernel?
> >
> >  
> >
> 
> 
> IOApic's support binding of interrupt delivery in intel based platforms, 
> but I am unaware of tools which force this
> setting by default on Linux, but someone else may be able to point you 
> in that direction.  

http://people.redhat.com/arjanv/irqbalance


