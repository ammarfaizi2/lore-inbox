Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbSLNUWF>; Sat, 14 Dec 2002 15:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSLNUWE>; Sat, 14 Dec 2002 15:22:04 -0500
Received: from spiderman.spectsoft.com ([216.126.222.67]:46596 "EHLO
	trashbin1.spectsoft.com") by vger.kernel.org with ESMTP
	id <S265894AbSLNUWC>; Sat, 14 Dec 2002 15:22:02 -0500
Subject: Re: DMA from SCSI controller to PCI frame buffer memory.
From: Jason Howard <lists@spectsoft.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1039837312.25121.115.camel@irongate.swansea.linux.org.uk>
References: <1039806910.21196.29.camel@bmagic.spectsoft.com>
	 <1039837312.25121.115.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Organization: SpectSoft, LLC
Message-Id: <1039897793.21189.53.camel@bmagic.spectsoft.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 14 Dec 2002 12:29:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In theory you can mmap the frame buffer memory, then do O_DIRECT I/O
> into it. In practice it will buffer (I hope it still does). One of the
> problems is that there are huge lists of PCI->AGP DMA errata in
> chipsets.

I am not accessing the AGP bus as my frame buffer is located on the PCI
bus.
00:08.0 Multimedia video controller: Unknown device f1d0:efac
	Subsystem: Unknown device f1d0:efac
	Flags: bus master, stepping, medium devsel, latency 64, IRQ 10
	Memory at f4000000 (32-bit, non-prefetchable) [size=4K]
	Memory at f6000000 (32-bit, prefetchable) [size=16M]
(I am working with the second memory address)

Any recommendations on where to start hacking?  Would it be a good idea
to add O_DIRECT to a mmaped PCI space?  The kernel should not be doing
any buffering whatsoever, as we will be coming close to filling the pci
bus up with transfers from direct disk->fb already.  (We are already
doing buffering on the FB card as well)

Jason
-- 
 Jason Howard

Professional:
  SpectSoft, LLC
  http://www.spectsoft.com  jason@spectsoft.com      
  Phone: +1.209.847.7812    Fax: +1.209.847.7859
Personal:
  http://www.psinux.org     jason@psinux.org
  Cell: +1.209.968.1289
  Text Message: jasonsphone@psinux.org


