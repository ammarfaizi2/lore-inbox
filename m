Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVHPFoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVHPFoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVHPFoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:44:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28379 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751098AbVHPFoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:44:20 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: hyoshiok@miraclelinux.com, lkml.hyoshiok@gmail.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050816.131729.15816429.taka@valinux.co.jp>
References: <1124096021.3228.20.camel@laptopd505.fenrus.org>
	 <98df96d3050815163331d6cce1@mail.gmail.com>
	 <20050816.123042.424254477.hyoshiok@miraclelinux.com>
	 <20050816.131729.15816429.taka@valinux.co.jp>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 07:44:13 +0200
Message-Id: <1124171054.3215.2.camel@laptopd505.fenrus.org>
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

On Tue, 2005-08-16 at 13:17 +0900, Hirokazu Takahashi wrote:
> Hi,
> 
> BTW, what are you going to do with the page-faults which may happen
> during __copy_user_zeroing_nocache()? The current process may be blocked
> in the handler for a while and get FPU registers polluted.
> kernel_fpu_begin() won't help the case. This is another issue, though.


__copy_from_user_inatomic

.. that implies it won't sleep actually ;)



