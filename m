Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVAPWXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVAPWXl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVAPWRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:17:23 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:45957 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262631AbVAPWP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:15:27 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, brking@us.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050116044823.GA55143@muc.de>
References: <1105641991.4664.73.camel@localhost.localdomain>
	 <20050113202354.GA67143@muc.de>
	 <1105645491.4624.114.camel@localhost.localdomain>
	 <20050113215044.GA1504@muc.de>
	 <1105743914.9222.31.camel@localhost.localdomain>
	 <20050115014440.GA1308@muc.de>
	 <1105750898.9222.101.camel@localhost.localdomain>
	 <1105770012.27411.72.camel@gaston>
	 <1105829883.15835.6.camel@localhost.localdomain>
	 <1105848104.27436.97.camel@gaston>  <20050116044823.GA55143@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105907495.12201.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 16 Jan 2005 21:10:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-16 at 04:48, Andi Kleen wrote:
> I just request that this shouldn't be done in the low level pci_config_read_*
> functions. Please keep them simple and lean. If you want such complex 
> semantics for user space do it in a separate layer.

It seems reasonable not to implement the wait (if not essential) in the
pci_config_* cases just in the pci user ones (as Brian was doing in the
later patches). 

