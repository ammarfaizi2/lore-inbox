Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270328AbTGRS6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 14:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271792AbTGRS55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 14:57:57 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:36868 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271785AbTGRS5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 14:57:49 -0400
Date: Fri, 18 Jul 2003 20:12:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b4).
Message-ID: <20030718201243.B13712@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B0598B10@AVEXCH02.qlogic.org> <20030718122304.A23013@infradead.org> <1058536002.5950.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1058536002.5950.3.camel@laptop.fenrus.com>; from arjanv@redhat.com on Fri, Jul 18, 2003 at 03:46:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 03:46:42PM +0200, Arjan van de Ven wrote:
> On Fri, 2003-07-18 at 13:23, Christoph Hellwig wrote:
> >  
> >  - qla2x00_intr_handler should use spin_lock, not spin_lock_irqsave
> 
> possibly correct; on x86 irq handlers run with interrupts enabled for
> example; just too dangerous to do this esp if error recovery and similar
> code calls this from process context as well (iirc a few places do)

Well, that's only true for SA_INTERRUPT.  But I missed that qla2xxx
sets this.  So drop þhat comment.
