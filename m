Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVDTMeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVDTMeU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVDTMeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:34:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34453 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261399AbVDTMeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:34:16 -0400
Subject: Re: [RFC][PATCH] nameing reserved pages [0/3]
From: Arjan van de Ven <arjan@infradead.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       hari@in.ibm.com
In-Reply-To: <426644DA.70105@jp.fujitsu.com>
References: <426644DA.70105@jp.fujitsu.com>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 14:34:06 +0200
Message-Id: <1114000447.6238.64.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 21:02 +0900, KAMEZAWA Hiroyuki wrote:
> Hi,
> 
> There are several types of PG_reserved pages,
> (a) Memory Hole
> (b) Used by Kernel
> (c) Set by drivers
> (d) Isorated by MCA
> (e) used by perfmon
> etc....
> 
> I think it's useful to distinguish many types of PG_reserved pages.

I'm not so sure about this. at all.

> For example, Memory Hotplug can ignore (a).

Memory Hotplug can also use page_is_ram().

/dev/memstate really looks like a bad idea to me as well... I rather
have less than more /dev/*mem*



