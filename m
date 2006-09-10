Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWIJNSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWIJNSr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWIJNSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:18:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16345 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932135AbWIJNSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:18:45 -0400
Subject: Re: [v4l-dvb-maintainer] DVB build fails without I2C
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Manu Abraham <abraham.manu@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       v4l-dvb-maintainer@linuxtv.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4502DA2F.5050905@gmail.com>
References: <45029DB0.5020300@garzik.org>  <4502DA2F.5050905@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 10 Sep 2006 10:17:06 -0300
Message-Id: <1157894226.4359.10.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sáb, 2006-09-09 às 19:13 +0400, Manu Abraham escreveu:
> Jeff Garzik wrote:
> > Recommended solution:  Add I2C as a dependency (or select) in DVB Kconfig.
> DVB-CORE does not depend on I2C, since it does not rely on any I2C at
> all. (DVB-CORE can use other methods) It is the PCI bridges that depend
> on I2C.
Yes. There are even a few dvb drivers that doesn't depend on I2C.
>  IIRC, we had a patch adding I2C dependencies for the Kconfig for
> the relevant bridge chips. The frontends which are connected to the
> bridges, depend on DVB-Core and I2C. So that dependency exists.
> 
> frontends foo
> depends on DVB_CORE && I2C
> 
> pci bridges foo
> depends on DVB_CORE && I2C && PCI
> 
> Maybe that patch has not made it yet to mainline.
No, it didn't arrived mainstream. It arrived only -mm series. The patch
depends a previous patch that added DVB attach support. Somebody offered
to backport it to 2.6.18 at #v4l channel (I'm not sure but I think it
was adq).

Cheers, 
Mauro.

