Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVHYH4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVHYH4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 03:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVHYH4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 03:56:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11673 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964864AbVHYH4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 03:56:09 -0400
Subject: Re: [patch] Additions to .data.read_mostly section
From: Arjan van de Ven <arjan@infradead.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
In-Reply-To: <20050824214610.GA3675@localhost.localdomain>
References: <20050824214610.GA3675@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 09:56:03 +0200
Message-Id: <1124956563.3222.8.camel@laptopd505.fenrus.org>
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

On Wed, 2005-08-24 at 14:46 -0700, Ravikiran G Thirumalai wrote:
> Following patch moves a few static 'read mostly' variables to the 
> .data.read_mostly section.  Typically these are vector - irq tables,
> boot_cpu_data, node_maps etc., which are initialized once and read from 
> often and rarely written to.  Please include.

it almost sounds like a "read_only_once_booted" is useful, esp for those
who modify their kernel to make such sections truely read only ;)


