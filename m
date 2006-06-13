Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWFMVqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWFMVqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWFMVqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:46:42 -0400
Received: from es335.com ([67.65.19.105]:40994 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S932344AbWFMVql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:46:41 -0400
Subject: RE: [openib-general] [PATCH v2 1/2] iWARP Connection Manager.
From: Steve Wise <swise@opengridcomputing.com>
To: Sean Hefty <sean.hefty@intel.com>
Cc: Tom Tucker <tom@opengridcomputing.com>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <000001c68f31$78910fe0$24268686@amr.corp.intel.com>
References: <000001c68f31$78910fe0$24268686@amr.corp.intel.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:46:36 -0500
Message-Id: <1150235196.17394.91.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 14:36 -0700, Sean Hefty wrote:
> >> Er...no. It will lose this event. Depending on the event...the carnage
> >> varies. We'll take a look at this.
> >>
> >
> >This behavior is consistent with the Infiniband CM (see
> >drivers/infiniband/core/cm.c function cm_recv_handler()).  But I think
> >we should at least log an error because a lost event will usually stall
> >the rdma connection.
> 
> I believe that there's a difference here.  For the Infiniband CM, an allocation
> error behaves the same as if the received MAD were lost or dropped.  Since MADs
> are unreliable anyway, it's not so much that an IB CM event gets lost, as it
> doesn't ever occur.  A remote CM should retry the send, which hopefully allows
> the connection to make forward progress.
> 

hmm.  Ok.  I see.  I misunderstood the code in cm_recv_handler().

Tom and I have been talking about what we can do to not drop the event.
Stay tuned.

Steve.

