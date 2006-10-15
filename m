Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWJOWdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWJOWdH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 18:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWJOWdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 18:33:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25579 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161192AbWJOWdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 18:33:05 -0400
Subject: Re: [PATCH 1/5] remove TxStartThresh and RxEarlyThresh
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Huang <jesse@icplus.com.tw>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
In-Reply-To: <1160947597.22522.3.camel@localhost.localdomain>
References: <1160855725.2266.1.camel@localhost.localdomain>
	 <1160947597.22522.3.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Oct 2006 23:59:20 +0100
Message-Id: <1160953160.5732.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-16 am 07:26 +1000, ysgrifennodd Benjamin Herrenschmidt:
> On Sat, 2006-10-14 at 15:55 -0400, Jesse Huang wrote:
> > From: Jesse Huang <jesse@icplus.com.tw>
> > 
> > Change Logs:
> > For patent issue need to remove TxStartThresh and RxEarlyThresh. This patent 
> > is cut-through patent. If use this function, Tx will start to transmit after 
> > few data be move in to Tx FIFO. We are not allow to use those function in 
> > DFE530/DFE550/DFE580/DL10050/IP100/IP100A. It will decrease a little 
> > performance.
> 
> Somebody patented FIFO thresholds ? Gack ?

3COM hold several patents on certain kinds of early interrupt/early
start for network FIFOs. At least historically they also had a GPL Linux
driver that didn't use that feature on their own cards which I'm told
was fear of patent "leakage"

Alan
