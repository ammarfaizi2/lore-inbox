Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbUEHPKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUEHPKx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 11:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUEHPKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 11:10:52 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:25353 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263169AbUEHPKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 11:10:50 -0400
Date: Sat, 8 May 2004 16:10:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       hch@infradead.org
Subject: Re: [PATCH] sym53c500_cs PCMCIA SCSI driver (round 5)
Message-ID: <20040508161045.A9590@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20040504060451.5BA10DBDE@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040504060451.5BA10DBDE@gherkin.frus.com>; from rct@gherkin.frus.com on Tue, May 04, 2004 at 01:04:51AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 01:04:51AM -0500, Bob Tracy wrote:
> Support for additional sysfs class device attributes has been added:
> two are read-only (irq, ioport),

sorry to bother you again, but I don't think these belong into a scsi
LLDD.  it's attributes for the underlying bus.  For pci you get these
information already, but the pcmcia infrastructure isn't quite ready
yet.

> one is read-write (fast_pio).  The
> read-write attribute is a per-instance flag indicating the PIO speed
> of the particular HBA: valid values are 1 (enabled -- default) and 0
> (disabled).

this one is nice.

