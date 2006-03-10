Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWCJO7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWCJO7U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 09:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWCJO7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 09:59:20 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:11551 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751494AbWCJO7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 09:59:19 -0500
X-IronPort-AV: i="4.02,181,1139212800"; 
   d="scan'208"; a="1783886033:sNHT30936300"
To: Greg KH <gregkh@suse.de>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 8 of 20] ipath - sysfs support for core driver
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1141950930@eng-12.pathscale.com>
	<1123028ac13ac1de2457.1141950938@eng-12.pathscale.com>
	<20060310011106.GD9945@suse.de>
	<1141967377.14517.32.camel@camp4.serpentine.com>
	<20060310063724.GB30968@suse.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 10 Mar 2006 06:59:15 -0800
Message-ID: <adairqmbb24.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Mar 2006 14:59:16.0497 (UTC) FILETIME=[33945010:01C64453]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> The main issue is that if you create a sysfs file like this,
    Greg> and then in 3 months realize that you need to change one of
    Greg> those characters to be something else, you are in big
    Greg> trouble...

I think that PortInfo and NodeInfo might be fair game for sysfs files,
because they are actually defined in the IB spec with a binary format
that is sent on the wire.  So they're not going to change.

On the other hand it's not clear to me why using that wire protocol as
an interface to userspace is a good idea...

 - R.
