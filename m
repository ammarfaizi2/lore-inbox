Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274871AbTHFFoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274876AbTHFFoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:44:05 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:20231 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S274858AbTHFFoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:44:03 -0400
Date: Wed, 6 Aug 2003 06:43:53 +0100
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Mukker, Atul" <atulm@lsil.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>
Subject: Re: [ANNOUNCE] megaraid linux driver version 2.00.7
Message-ID: <20030806064353.A21769@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Mukker, Atul" <atulm@lsil.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E570185F3FA@EXA-ATLANTA.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570185F3FA@EXA-ATLANTA.se.lsil.com>; from atulm@lsil.com on Tue, Aug 05, 2003 at 06:09:10PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 06:09:10PM -0400, Mukker, Atul wrote:
> > +	spin_lock_irqsave(adapter->host->host_lock, flags);
> But all kernels do not have this lock as part of the host structure. With
> 2.00.7, I have relapsed a patch which switches the lock to io_request_lock
> if kernel does not support per host lock.
> 
> And not all kernels have the per host lock named as "host->host_lock", some
> simply have "host->lock"A

All 2.5/2.6 kernels do have host->host_lock and the 2.5 driver is different
from the 2.4 one.  In fact it will hopefuloly become &host->host_lock soon
but for that I have to repair the remaining abusers first.

