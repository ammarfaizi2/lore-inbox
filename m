Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVCPKgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVCPKgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVCPKgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:36:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18123 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262346AbVCPKeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:34:24 -0500
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, rostedt@goodmis.org, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050316022638.237f72cd.akpm@osdl.org>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	 <20050315120053.GA4686@elte.hu>
	 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	 <20050315133540.GB4686@elte.hu>
	 <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
	 <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org>
	 <20050316095155.GA15080@elte.hu> <20050316020408.434cc620.akpm@osdl.org>
	 <20050316101209.GA16893@elte.hu>  <20050316022638.237f72cd.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 11:34:08 +0100
Message-Id: <1110969248.6292.2.camel@laptopd505.fenrus.org>
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

On Wed, 2005-03-16 at 02:26 -0800, Andrew Morton wrote:
> 
> The hold times are short, and a context switch hurts rather ore than a
> quick
> spin.

so we need a spinaphore ;)


