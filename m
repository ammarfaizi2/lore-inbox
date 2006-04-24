Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWDYA5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWDYA5b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 20:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWDYA5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 20:57:30 -0400
Received: from mms3.broadcom.com ([216.31.210.19]:54281 "EHLO
	MMS3.broadcom.com") by vger.kernel.org with ESMTP id S1751284AbWDYA53
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 20:57:29 -0400
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Subject: Re: Van Jacobson's net channels and real-time
From: "Michael Chan" <mchan@broadcom.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: "Auke Kok" <auke-jan.h.kok@intel.com>, "Ingo Oeser" <ioe-lkml@rameria.de>,
       "=?ISO-8859-1?Q?J=F6rn?= Engel" <joern@wohnheim.fh-wedel.de>,
       "Ingo Oeser" <netdev@axxeo.de>, "David S. Miller" <davem@davemloft.net>,
       simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu,
       netdev@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0604241254180.24099@chaos.analogic.com>
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk>
 <200604221529.59899.ioe-lkml@rameria.de>
 <20060422134956.GC6629@wohnheim.fh-wedel.de>
 <200604230205.33668.ioe-lkml@rameria.de> <444CFFE5.1020509@intel.com>
 <Pine.LNX.4.61.0604241254180.24099@chaos.analogic.com>
Date: Mon, 24 Apr 2006 16:17:07 -0700
Message-ID: <1145920628.7998.8.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006042408; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230332E34343444373236302E303031342D412D;
 ENG=IBF; TS=20060425005719; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006042408_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6853AC673NG10166185-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 12:59 -0400, linux-os (Dick Johnson) wrote:

> Message signaled interrupts are just a kudge to save a trace on a
> PC board (read make junk cheaper still). They are not faster and
> may even be slower. They will not be the salvation of any interrupt
> latency problems.

MSI has 2 very nice properties: MSI is never shared and MSI guarantees
that all DMA activities before the MSI have completed. When you take
advantage of these guarantees in your MSI handler, there can be
noticeable improvements compared to using INTA.

