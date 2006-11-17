Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933597AbWKQRrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933597AbWKQRrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933745AbWKQRrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:47:46 -0500
Received: from homer.mvista.com ([63.81.120.158]:1759 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S933597AbWKQRrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:47:45 -0500
Subject: Re: [PATCH] Allow NULL pointers in percpu_free
From: Daniel Walker <dwalker@mvista.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Jens Axboe <axboe@kernel.dk>, Christoph Lameter <clameter@sgi.com>,
       Pedro Roque <roque@di.fc.ul.pt>,
       "David S. Miller" <davem@davemloft.net>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0611171224150.2261-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0611171224150.2261-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 09:47:33 -0800
Message-Id: <1163785653.3097.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 12:36 -0500, Alan Stern wrote:

>  void percpu_free(void *__pdata)
>  {
> +	if (!__pdata)
> +		return;

Should be unlikely() right?

Daniel

