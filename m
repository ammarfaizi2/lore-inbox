Return-Path: <linux-kernel-owner+w=401wt.eu-S1751687AbWLMXFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWLMXFO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWLMXFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:05:14 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54698 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbWLMXFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:05:12 -0500
Date: Wed, 13 Dec 2006 15:01:43 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Thomas Graf <tgraf@suug.ch>
Cc: Al Viro <viro@ftp.linux.org.uk>, David Miller <davem@davemloft.net>,
       bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
Message-ID: <20061213150143.2672e0b1@dxpl.pdx.osdl.net>
In-Reply-To: <20061213204933.GW8693@postel.suug.ch>
References: <20061212162435.GW28443@stusta.de>
	<20061212.171756.85408589.davem@davemloft.net>
	<20061213201213.GK4587@ftp.linux.org.uk>
	<20061213204933.GW8693@postel.suug.ch>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 21:49:33 +0100
Thomas Graf <tgraf@suug.ch> wrote:

> * Al Viro <viro@ftp.linux.org.uk> 2006-12-13 20:12
> > On Tue, Dec 12, 2006 at 05:17:56PM -0800, David Miller wrote:
> > > I'm not sure whether that is important any longer.  It probably isn't,
> > > but we should verify it before applying such a patch.
> > 
> > There might be practical considerations along the lines of "we want
> > lookups for loopback to be fast"...
> 
> What is this discussion actually about? Since we started registering
> devices directly hooked into the init process before device_initcall()
> the order is random. Even the bonding device is registered before the
> loopback.
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Loopback should be there before protocols are started. It makes sense
to have a standard startup order.
