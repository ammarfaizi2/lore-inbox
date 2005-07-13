Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVGMLi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVGMLi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVGMLi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 07:38:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53663 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262744AbVGMLiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 07:38:17 -0400
Subject: Re: Runtime fix for intermodule.c
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0507131255130.14635@yvahk01.tjqt.qr>
References: <20050712213920.GA9714@physik.fu-berlin.de>
	 <20050712220705.GA12906@infradead.org>
	 <Pine.LNX.4.61.0507131255130.14635@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 13:38:09 +0200
Message-Id: <1121254689.3959.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 12:56 +0200, Jan Engelhardt wrote:
> >> since the symbol inter_module_get cannot be resolved,
> >> applying this patch will make those modules work again.
> >
> >There's a reason you shouldn't use it, and because of that it's
> >not exported.
> 
> Oh BTW, while we're at it: With what should I replace inter_module_get? I'm 
> maintaining an "ancient-sufficient" nvidia driver for myself that uses it in 
> one or two places.

if it does that to talk to agp you have to remove it since the agp side
of things isn't there anymore since several kernel releases.


