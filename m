Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTF0WpK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTF0WpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:45:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19849
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264879AbTF0WpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:45:07 -0400
Subject: Re: PATCH 2.4.21 fix: kswapd can fail starting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Walter Harms <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E19Vzla-000CR0-00@grossglockner.Informatik.Uni-Oldenburg.DE>
References: <E19Vzla-000CR0-00@grossglockner.Informatik.Uni-Oldenburg.DE>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056754583.5463.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jun 2003 23:56:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-27 at 21:24, Walter Harms wrote:
> Hi list,
> when i was looking for non checked returns of kernel_thread() i noticed
> that vmscan.c never checks. This patch changes that. Note that
> kswapd_init() can fail. I have no idea what to do then perhaps somebody
> should take a look at that also ?

I suspect this one is at best a

BUG_ON(blah < 0)

