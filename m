Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVA0L5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVA0L5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVA0L5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:57:47 -0500
Received: from canuck.infradead.org ([205.233.218.70]:779 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262587AbVA0L5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:57:36 -0500
Subject: Re: Patch 0/6  virtual address space randomisation
From: Arjan van de Ven <arjanv@infradead.org>
To: Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <41F8D44D.9070409@francetelecom.REMOVE.com>
References: <20050127101117.GA9760@infradead.org>
	 <41F8D44D.9070409@francetelecom.REMOVE.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 12:57:30 +0100
Message-Id: <1106827050.5624.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 12:45 +0100, Julien TINNES wrote:
> Arjan van de Ven wrote:
> > The randomisation patch series introduces infrastructure and functionality
> > that causes certain parts of a process' virtual address space to be
> > different for each invocation of the process. The purpose of this is to
> > raise the bar on buffer overflow exploits; full randomisation makes it not
> > possible to use absolute addresses in the exploit.
> > 
> 
> I think it is worth mentioning that this is part of PaX ASLR, but with 
> some changes and simplification.

it actually came from Exec-Shield not PaX

> I have some questions about the changes:
> 
> for RANDMMAP why doing randomization in mmap_base() and not in 
> arch_pick_mmap_layout? You miss a whole case here where legacy layout is 
> used.

legacy layout will want a different randomisation; it'll come in a
separate, incremental patch.


