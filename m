Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVCILKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVCILKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVCILKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:10:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24808 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261599AbVCILKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:10:40 -0500
Subject: Re: aio stress panic on 2.6.11-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: suparna@in.ibm.com
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050309110404.GA4088@in.ibm.com>
References: <20050308170107.231a145c.akpm@osdl.org>
	 <1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com>
	 <18744.1110364438@redhat.com>  <20050309110404.GA4088@in.ibm.com>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 12:10:13 +0100
Message-Id: <1110366614.6280.86.camel@laptopd505.fenrus.org>
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

On Wed, 2005-03-09 at 16:34 +0530, Suparna Bhattacharya wrote:
> Any sense of how costly it is to use spin_lock_irq's vs spin_lock
> (across different architectures) ? Isn't rwsem used very widely ?

oh also rwsems aren't used all that much simply because they are quite
more expensive than regular semaphores, so that you need a HUGE bias in
reader/writer ratio to make it even worth it...

