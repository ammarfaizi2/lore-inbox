Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVCVKwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVCVKwx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVCVKww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:52:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28080 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262621AbVCVKwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:52:37 -0500
Subject: RE: Fusion-MPT much faster as module
From: Arjan van de Ven <arjan@infradead.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Holger Kiehl'" <Holger.Kiehl@dwd.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       "Moore, Eric  Dean" <emoore@lsil.com>
In-Reply-To: <200503221029.j2MATNg12775@unix-os.sc.intel.com>
References: <200503221029.j2MATNg12775@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 11:52:22 +0100
Message-Id: <1111488742.7096.61.camel@laptopd505.fenrus.org>
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

On Tue, 2005-03-22 at 02:29 -0800, Chen, Kenneth W wrote:

> Before:
> /dev/sdc:
>  Timing buffered disk reads:   92 MB in  3.03 seconds =  30.32 MB/sec
> 
> After:
> /dev/sdc:
>  Timing buffered disk reads:  174 MB in  3.02 seconds =  57.61 MB/sec


nice!

More proof that #ifdef MODULE is considered harmful... how much of it is
actually left in the kernel? Maybe we could kill it entirely from
drivers/*  (of course it has a limited place in include/*)



