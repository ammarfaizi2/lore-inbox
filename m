Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbUDBQdw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUDBQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:33:52 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:23449 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264094AbUDBQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:33:51 -0500
Subject: Re: [PATCH] ppc64: create dma_mapping_error
From: James Bottomley <James.Bottomley@steeleye.com>
To: Anton Blanchard <anton@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 02 Apr 2004 11:33:34 -0500
Message-Id: <1080923616.1829.73.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What exactly are you guys doing?

The API Anton introduced:  dma_mapping_error() takes only a virtual
address as the argument (no struct device or anyting), so the additional
API's pci_dma_mapping_error() and vio_dma_mapping_error have absolutely
no choice but to do the same thing as dma_mapping_error() (because the
error return cannot be bus or device specific).

So, why bother introducing all these superfluous APIs in the first
place?  Just stick to the single dma_mapping_error(); it will be much
easier.

James


