Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135363AbREAOg5>; Tue, 1 May 2001 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135520AbREAOgr>; Tue, 1 May 2001 10:36:47 -0400
Received: from [64.64.109.142] ([64.64.109.142]:21767 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S135363AbREAOgi>; Tue, 1 May 2001 10:36:38 -0400
Message-ID: <3AEEC9D2.85526BAB@didntduck.org>
Date: Tue, 01 May 2001 10:36:02 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: mike_phillips@urscorp.com
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
In-Reply-To: <OFED368CB7.D5C74726-ON85256A3F.004547C6@urscorp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike_phillips@urscorp.com wrote:
> 
> To get the pcmcia ibmtr driver (ibmtr/ibmtr_cs) working on ppc, all the
> isa_read/write's have to be changed to regular read/write due to the lack
> of the isa_read/write functions for ppc.

Treat it like a PCI device and use ioremap().  Then change isa_readl()
to readl() etc.

--

				Brian Gerst
