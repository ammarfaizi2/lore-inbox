Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVCNKMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVCNKMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVCNKMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:12:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33433 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262106AbVCNKI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:08:59 -0500
Subject: Re: [PATCH 2.6] fix mprotect() with len=(size_t)(-1) to return
	-ENOMEM
From: Arjan van de Ven <arjan@infradead.org>
To: Gordon Jin <gordon.jin@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, michael.fu@intel.com
In-Reply-To: <1110794148.26254.45.camel@yjin3-dev.sh.intel.com>
References: <1110794148.26254.45.camel@yjin3-dev.sh.intel.com>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 11:08:51 +0100
Message-Id: <1110794932.6288.58.camel@laptopd505.fenrus.org>
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

On Mon, 2005-03-14 at 17:55 +0800, Gordon Jin wrote:
> This patch fixes a corner case in sys_mprotect(): 
> 
> Case: len is so large that will overflow to 0 after page alignment.

shouldn't we just fix the alignment code instead that the overflow case
doesn't align to 0???
that sounds really odd.


