Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVCIVXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVCIVXx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVCIUcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:32:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45957 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262373AbVCIULE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:11:04 -0500
Subject: Re: [PATCH] rwsem: Make rwsems use interrupt disabling spinlocks
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, dhowells@redhat.com,
       torvalds@osdl.org, suparna@in.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050309114234.6598f486.akpm@osdl.org>
References: <20050309032832.159e58a4.akpm@osdl.org>
	 <20050308170107.231a145c.akpm@osdl.org>
	 <1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com>
	 <18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com>
	 <1110366469.6280.84.camel@laptopd505.fenrus.org>
	 <4175.1110370343@redhat.com>
	 <1110395783.24286.207.camel@dyn318077bld.beaverton.ibm.com>
	 <20050309114234.6598f486.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 21:10:35 +0100
Message-Id: <1110399036.6280.151.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
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


> Ingo, we already have a touch_nmi_watchdog() in the sysrq code.  It might be
> worth adding a touch_softlockup_watchdog() wherever we have a
> touch_nmi_watchdog().

....or add touch_softlockup_watchdog to touch_nmi_watchdog() instead
and rename it tickle_watchdog() overtime.

