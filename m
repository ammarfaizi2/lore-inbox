Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVJZUBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVJZUBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVJZUBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:01:42 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:48838 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S964907AbVJZUBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:01:42 -0400
From: Steve Snyder <R00020C@freescale.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: "Badness in local_bh_enable" - a reasonable fix?
Date: Wed, 26 Oct 2005 16:01:19 -0400
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200510261534.38291.R00020C@freescale.com> <1130355615.3339.10.camel@laptopd505.fenrus.org>
In-Reply-To: <1130355615.3339.10.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510261601.19369.R00020C@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 15:40, Arjan van de Ven wrote:
> On Wed, 2005-10-26 at 15:34 -0400, Steve Snyder wrote:
> > [ I observed the following on a Fedora Core 3 system, running kernel 
> > 2.6.12-1.1380_FC3.  I am posting this here because a quick Googling 
> > indicates that the problem is not specific to this environment.  ] 
> > 
> > Today I found my system log filled with the error shown below.  
> > Reading a 366MB file across a NFS mount results in over 6300 
> > occurrences of the error being written to the system log of the NFS 
> > server.  
> > 
> > I have 2 network interfaces in the NFS server machine, a standard 
> > kernel Ethernet device driver and my own Ultra-Wide Band (UWB) device 
> > driver.  (In the error shown below the references to "fsuwbpci" are my 
> > driver.) This problem is not seen when using the Ethernet interface, 
> > but is perfectly consistent when reading a NFS-mounted file across the 
> > UWB interface.  Therefore there is a problem with my code.  
> > 
> > I quickly established that the error came from within this routine:
> > 
> 
> > -------------------------------------------
> > 
> > kernel: Badness in local_bh_enable at kernel/softirq.c:140 (Tainted: P     )
> 
> 
> 
> hmmm binary module? please try without.

What, you mean the driver?  No, it is built from source against the
installed & running Fedora Core 3 kernel version 2.6.12-1.1380_FC3.
