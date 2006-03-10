Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWCJNn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWCJNn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 08:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWCJNnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 08:43:25 -0500
Received: from mx.pathscale.com ([64.160.42.68]:9671 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751101AbWCJNnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 08:43:25 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <gregkh@suse.de>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <ada7j72detl.fsf@cisco.com>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <ada8xrjfbd8.fsf@cisco.com>
	 <1141948367.10693.53.camel@serpentine.pathscale.com>
	 <20060310004505.GB17050@suse.de>
	 <1141951725.10693.88.camel@serpentine.pathscale.com>
	 <20060310010403.GC9945@suse.de>
	 <1141965696.14517.4.camel@camp4.serpentine.com> <ada7j72detl.fsf@cisco.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 05:43:50 -0800
Message-Id: <1141998230.28926.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 21:55 -0800, Roland Dreier wrote:

> No, the only problems are with the way the various pieces of your
> drivers refer to devices by index.

OK.  What's a safe way to iterate over the devices in the presence of
hotplug, then?  I assume it's list_for_each_mumble; I just don't know
what mumble is :-)

> Also you only do this when the module is loaded, so you won't handle
> devices that are hot-plugged later.

No, ipath_max is updated any time a probe routine is called.

>   And I don't see anything that
> would handle hot unplug either.

What would this anything look like, if I were hoping for an example to
emulate?  There's nothing in LDD3 about this, so I'm kind of in the
dark.

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>

