Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270458AbTHLPZn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270461AbTHLPZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:25:43 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:64149 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270458AbTHLPZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:25:35 -0400
Subject: Re: [PATCH] [2.6.0-test3] request_firmware related problems.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, ranty@debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       willy@debian.org
In-Reply-To: <3F36CE8D.8090201@pobox.com>
References: <20030810210646.GA6746@ranty.pantax.net>
	 <20030810142928.4b734e8d.akpm@osdl.org> <3F36CD93.4010704@pobox.com>
	 <3F36CE8D.8090201@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060701706.21159.26.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Aug 2003 16:21:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-08-11 at 00:00, Jeff Garzik wrote:
> > 2) ponder perhaps an implementation that would use generic keventd until 
> > a certain load is reached; then, create per-cpu kernel threads just like 
> > private workqueue creation occurs now.  i.e. switch from shared 
> > (keventd) to private at runtime.
> 
> 
> 3) offer private workqueue interface like we have now -- but one thread 
> only, not NN threads

4) Have one permanent thread running which kicks off another thread
whenever something has been on the queue for more than 5 seconds and
reaps threads when the queue is empty for 30 ?

