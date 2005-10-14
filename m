Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVJNKVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVJNKVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 06:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVJNKVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 06:21:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36535 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750712AbVJNKVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 06:21:01 -0400
Subject: Re: [patch] optimize disk_round_stats
From: Arjan van de Ven <arjan@infradead.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, "'Jens Axboe'" <axboe@suse.de>
In-Reply-To: <200510131919.j9DJJkg07781@unix-os.sc.intel.com>
References: <200510131919.j9DJJkg07781@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 12:19:46 +0200
Message-Id: <1129285187.2873.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
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

On Thu, 2005-10-13 at 12:19 -0700, Chen, Kenneth W wrote:
> Following the same idea, it occurs to me that we should only update
> disk stat when "now" is different from disk->stamp.  Otherwise, we
> are again needlessly adding zero to the stats.

have you measured this?
Conditionals in code are not free, so it might well be more expensive...

