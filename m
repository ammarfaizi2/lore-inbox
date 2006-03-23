Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWCWJvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWCWJvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWCWJvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:51:05 -0500
Received: from mx.pathscale.com ([64.160.42.68]:44689 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751442AbWCWJvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:51:04 -0500
Subject: Re: [PATCH 9 of 18] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, greg@kroah.com,
       openib-general@openib.org
In-Reply-To: <20060323093713.GB1802@mellanox.co.il>
References: <patchbomb.1143072293@eng-12.pathscale.com>
	 <dffa0687112e4fdcf7d0.1143072302@eng-12.pathscale.com>
	 <20060323064113.GC9841@mellanox.co.il>
	 <1143103701.6411.21.camel@camp4.serpentine.com>
	 <20060323093713.GB1802@mellanox.co.il>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 01:51:03 -0800
Message-Id: <1143107463.6411.54.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 11:37 +0200, Michael S. Tsirkin wrote:

> I understand they do, but they could just use the parts of IB stack and never
> notice.

No, in some cases they want there to not be an IB stack present, which
is not the same thing at all as not caring if it's there.

> I think IB stack is modest, as core modules go.

I don't understand why you persist on this point.  We have a need for an
SMA that is not tied to the IB stack.  The kernel code to support it is
about 500 lines long, about 2% of the driver.

> And I don't believe you can save much since as a solution you seem to have
> re-implemented the full IB stack in your low level driver:

No, we haven't.  The IB protocols are implemented in the ib_ipath
module, not the core driver.

	<b

