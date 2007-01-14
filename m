Return-Path: <linux-kernel-owner+w=401wt.eu-S1750915AbXANOpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbXANOpw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 09:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbXANOpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 09:45:52 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:54240 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750915AbXANOpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 09:45:51 -0500
X-Sasl-enc: 8H3cd6wzjviipty06iXc11OMOQUzFaz8gVuECDMNymJs 1168785950
Date: Sun, 14 Jan 2007 12:45:46 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] disable NMI watchdog by default
Message-ID: <20070114144546.GC1268@khazad-dum.debian.net>
References: <20070114092926.GA14465@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114092926.GA14465@elte.hu>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2007, Ingo Molnar wrote:
> And with this my laptop (Lenovo T60) also stops its sporadic hard 
> hanging (sometimes in acpi_init(), sometimes later during bootup, 
> sometimes much later during actual use) as well. It hung with both 
> nmi_watchdog=1 and nmi_watchdog=2, so it's generally the fact of NMI 
> injection that is causing problems, not the NMI watchdog variant, nor 
> any particular bootup code.

I seem to recall a patch sent to lkml that removed nmi_watchdog
functionality from ThinkPads exactly because of this.  Something to do with
SMBIOS code calling int 10h under SMM, and that it would hang hard if NMIs
happened at that time.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
