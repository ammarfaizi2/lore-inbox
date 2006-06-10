Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751669AbWFJRhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbWFJRhl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 13:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWFJRhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 13:37:41 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29376 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751664AbWFJRhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 13:37:40 -0400
Message-ID: <448B0362.8030901@garzik.org>
Date: Sat, 10 Jun 2006 13:37:38 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, promise_linux@promise.com
Subject: Re: [PATCH] Promise 'stex' driver
References: <20060610160852.GA15316@havoc.gtf.org> <20060610170640.GA25118@infradead.org>
In-Reply-To: <20060610170640.GA25118@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, just did several of these and checked it into 'stex' branch.

commit 1b6f2a81e789ebef27107765656d425ab44a2f44
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Jun 10 13:36:54 2006 -0400

     [SCSI] stex: minor cleanups

     - fix endian bug found in s/g code (used a fixed-endian value
       as a loop-terminating variable)

     From a list of changes suggested by Christoph:

     - don't include linux/config.h
     - whitespace fix
     - let compiler choose whether or not to inline
     - eliminate unnecessary NULL test on hba->dma_mem
     - handle pci_map_sg() error

