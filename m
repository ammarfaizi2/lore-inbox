Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVBVOwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVBVOwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 09:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVBVOwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 09:52:08 -0500
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:46012 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S262317AbVBVOwC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 09:52:02 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: cciss CSMI via sysfs for 2.6
Date: Tue, 22 Feb 2005 08:50:58 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC02D9@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss CSMI via sysfs for 2.6
Thread-Index: AcUWtvJKQtdM6ja8Q2qJym6l0PXBqQCNsddA
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Toon van der Pas" <toon@hout.vanvergehaald.nl>
Cc: <linux-kernel@vger.kernel.org>, <mochel@osdl.org>, <akpm@osdl.org>,
       <eric.moore@lsil.com>
X-OriginalArrivalTime: 22 Feb 2005 14:51:02.0164 (UTC) FILETIME=[ED8C5540:01C518ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Toon van der Pas [mailto:toon@hout.vanvergehaald.nl]
> > +
> > +	iocommand.IoctlHeader.Length = sizeof(CSMI_SAS_PHY_INFO_BUFFER);
> > +	c->cmd_type = CMD_IOCTL_PEND;
> > +	c->Header.ReplyQueue = 0;
> > +		
> > +	//Do we send the whole buffer?
> > +	if (iocommand.IoctlHeader.Length > 0){
> 
> This test will always be true, no?

Yes, I'll fix that. 

Thanks,
mikem

> 
> > +		c->Header.SGList = 1;
> > +		c->Header.SGTotal = 1;
> > +	} else {
> > +		c->Header.SGList = 0;
> > +		c->Header.SGTotal = 0;
> > +	}
> 
> -- 
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
> 
