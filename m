Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVBAHhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVBAHhB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVBAHhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:37:01 -0500
Received: from canuck.infradead.org ([205.233.218.70]:22544 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261674AbVBAHg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:36:58 -0500
Subject: Re: question on symbol exports
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41FECA18.50609@nortelnetworks.com>
References: <41FECA18.50609@nortelnetworks.com>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 08:36:37 +0100
Message-Id: <1107243398.4208.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 18:15 -0600, Chris Friesen wrote:
> It appears that in 2.6.9 the ppc64 version of flush_tlb_page() depends 
> on two symbols which are not currently exported: the function 
> __flush_tlb_pending(), and the per-cpu variable ppc64_tlb_batch.
> 
> Is there any particular reason why modules should not be allowed to 
> flush the tlb, or is this an oversight?

can you point at the url to your module source? I suspect modules doing
tlb flushes is the wrong thing, but without seeing the source it's hard
to tell.


