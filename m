Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUDPFkh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 01:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUDPFkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 01:40:37 -0400
Received: from magic.adaptec.com ([216.52.22.17]:64434 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262398AbUDPFke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 01:40:34 -0400
Date: Fri, 16 Apr 2004 11:14:09 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: How does ioremap() get non-cached mappings
In-Reply-To: <407F6FF8.1020904@quark.didntduck.org>
Message-ID: <Pine.LNX.4.44.0404161111250.17679-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Apr 2004 05:40:30.0588 (UTC) FILETIME=[544FD3C0:01C42375]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004, Brian Gerst wrote:

> Nagendra Singh Tomar wrote:
> > ioremap() function in x86 arch code does not seem to be setting _PAGE_PCD 
> > bit in the PTE. How then does it give non-cached mapping to MMIO mappings 
> > for memory on some interface card. I have gone thru some old threads on 
> > this, which have concluded that it does give non-cached mappings, and 
> > moerover ioremap seems to work fine whenever I have used to map any PCI 
> > card memory,
> > Is it guaranteed thru the means of MTRR ?
> > 
> 
> ioremap_nocache()

I'm aware of ioremap_nocache(), and the fact that it explicitly sets 
_PAGE_PCD. My  question originated after reading this posting by Alan

http://www.uwsg.iu.edu/hypermail/linux/kernel/0110.0/0878.html

in which he explicitly states that ioremap() gives uncached mapping. If 
you follow the thread, there is a general consensus that ioremap and 
ioremap_nocache are functionaly the same on x86 arch (and I suppose on 
most archs)

Thanx,
tomar
> 
> --
> 				Brian Gerst
> 

-- 



-- You have moved the mouse. Windows must be restarted for the 
   changes to take effect.

