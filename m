Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbULPRDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbULPRDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbULPRDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:03:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:26251 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261847AbULPRBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:01:49 -0500
Message-ID: <41C1BA38.60304@osdl.org>
Date: Thu, 16 Dec 2004 08:39:20 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci
References: <200412160850.20223.jbarnes@engr.sgi.com>
In-Reply-To: <200412160850.20223.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> This patch documents the /proc/bus/pci interface and adds some optional 
> architecture specific APIs for accessing legacy I/O port and memory space.  
> This is necessary on platforms where legacy I/O port space doesn't 'soft 
> fail' like it does on PCs, and is useful for systems that can route legacy 
> space to different PCI busses.
> 
> I've incorporated all the feedback I've received so far, so I think it's ready 
> to send on to Andrew for inclusion, if someone could give the proc-pci.txt 
> documentation a last read (and/or comment on other stuff I may have missed).

meta-comment:
Would you (and not just you :) include a diffstat summary so we
can see which files are being changed?  something like this:


  Documentation/filesystems/proc-pci.txt |  126 
+++++++++++++++++++++++++++++++++
  arch/ia64/pci/pci.c                    |  105 
+++++++++++++++++++++++++++
  arch/ia64/sn/pci/pci_dma.c             |   74 +++++++++++++++++++
  drivers/pci/proc.c                     |  100 +++++++++++++++++++++++---
  include/asm-ia64/machvec.h             |   24 ++++++
  include/asm-ia64/machvec_init.h        |    3
  include/asm-ia64/machvec_sn2.h         |    6 +
  include/asm-ia64/pci.h                 |    4 +
  include/asm-ia64/sn/sn_sal.h           |   47 ++++++++++++
  include/linux/pci.h                    |   12 ++-
  10 files changed, 488 insertions(+), 13 deletions(-)

-- 
~Randy
