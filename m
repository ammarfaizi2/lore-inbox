Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWC3VHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWC3VHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWC3VHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:07:00 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:64038 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750899AbWC3VHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:07:00 -0500
X-IronPort-AV: i="4.03,147,1141632000"; 
   d="scan'208"; a="318520206:sNHT41569700"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 16 of 16] ipath - kbuild infrastructure
X-Message-Flag: Warning: May contain useful information
References: <36bfb4f1ad322a8fb23e.1143674619@chalcedony.internal.keyresearch.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 30 Mar 2006 13:06:58 -0800
In-Reply-To: <36bfb4f1ad322a8fb23e.1143674619@chalcedony.internal.keyresearch.com> (Bryan O'Sullivan's message of "Wed, 29 Mar 2006 15:23:39 -0800")
Message-ID: <adaek0j1w25.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Mar 2006 21:06:59.0269 (UTC) FILETIME=[E2472750:01C6543D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, have you tried building with CONFIG_IPATH_CORE=y but
CONFIG_INFINIBAND=n?  It looks like it won't work, because the only
way for the build system to reach the driver source is via

obj-$(CONFIG_INFINIBAND)	+= infiniband/

in drivers/Makefile.

I'm not sure what the cleanest way to fix this.

Sorry for not noticing this sooner...

 - R.


