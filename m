Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbTFLSjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbTFLSjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:39:44 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:38584 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S264943AbTFLSjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:39:43 -0400
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andy Pfiffer <andyp@osdl.org>, adam@yggdrasil.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030612111005.389e065b.akpm@digeo.com>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	 <1052513725.15923.45.camel@andyp.pdx.osdl.net>
	 <1055369326.1158.252.camel@andyp.pdx.osdl.net>
	 <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	 <1055377253.1222.8.camel@andyp.pdx.osdl.net>
	 <20030611172958.5e4d3500.akpm@digeo.com>
	 <1055438856.1202.6.camel@andyp.pdx.osdl.net>
	 <20030612105347.6ea644b7.akpm@digeo.com>
	 <1055441028.1202.11.camel@andyp.pdx.osdl.net>
	 <20030612111005.389e065b.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1055443998.549.0.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 20:53:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2003-06-12 um 20.10 schrieb Andrew Morton:

> Also, what about this shot in the dark?

> -	wbc.nr_to_write = ps.nr_dirty + ps.nr_unstable +
> +	wbc.nr_to_write = ps.nr_dirty + ps.nr_unstable + 1024 +

Nope, still 4k dirty left after lilo.

-- 
Christophe Saout <christophe@saout.de>

