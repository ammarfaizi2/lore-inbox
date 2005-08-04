Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVHDRyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVHDRyO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVHDRyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:54:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49282 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261516AbVHDRyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:54:12 -0400
Subject: Re: [RFC] Move InfiniBand .h files
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <52iryla9r5.fsf@cisco.com>
References: <52iryla9r5.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 19:53:58 +0200
Message-Id: <1123178038.3318.40.camel@laptopd505.fenrus.org>
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

On Thu, 2005-08-04 at 10:32 -0700, Roland Dreier wrote:
> I would like to get people's reactions to moving the InfiniBand .h
> files from their current location in drivers/infiniband/include/ to
> include/linux/rdma/.  If we agree that this is a good idea then I'll
> push this change as soon as 2.6.14 starts.

please only put userspace clean headers here; the rest is more or less
private headers for your subsystem. 

At minimum the headers should be split in separate files for
shared-userspace and kernel (eg no overlap at all), but I'd vote for
keeping the headers in your own dir.

