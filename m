Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264121AbTDOV55 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264122AbTDOV55 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:57:57 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:61312
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S264121AbTDOV54 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 17:57:56 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DMA transfers in 2.5.67
References: <yw1x3ckjfs2v.fsf@zaphod.guide>
	<1050438684.28586.8.camel@dhcp22.swansea.linux.org.uk>
	<yw1xy92be915.fsf@zaphod.guide>
	<1050439715.28586.17.camel@dhcp22.swansea.linux.org.uk>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 16 Apr 2003 00:09:00 +0200
In-Reply-To: <1050439715.28586.17.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <yw1xptnne7lv.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > It's an Alpha with 768 MB.  Is it the pci_alloc_* functions you are
> > referring to?  I don't think they are used currently. How much memory
> > can these allocate?  I need chunks of up to 1 MB, not necessarily
> > phycically continuous.
> > 
> > What do those functions do that normal memory allocation does not?
> > Apart from setting up sg mappings, that is.
> 
> A normal memory allocation might not be visible from the device, however
> pci_map_sg() deals with such things. What I really meant was are you
> using the pci_ DMA functionality

Those functions are not used at the moment, but I could change that.
The question remains why DMA transfers are so slow.  The memory is
clearly visible from the bus.

Btw, I just noticed that hard disk throughput is much lower with 2.5
than 2.4.  With 2.4.21-pre5 I get ~40 MB/s, but with 2.5.67 the speed
drops to 25-30 MB/s.  Everything according to hdparm.  Is it possible
that DMA is generally slow for some reason?

-- 
Måns Rullgård
mru@users.sf.net
