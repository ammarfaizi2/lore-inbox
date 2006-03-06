Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751671AbWCFV6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWCFV6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbWCFV6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:58:53 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:55673 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751671AbWCFV6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:58:52 -0500
X-IronPort-AV: i="4.02,168,1139212800"; 
   d="scan'208"; a="1782383969:sNHT4843663260"
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: Sean Hefty <sean.hefty@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 6/6] IB: userspace support for RDMA connection manager
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX4011XvpFVjCRG00000009@orsmsx401.amr.corp.intel.com>
	<adaoe0j5kd6.fsf@cisco.com> <440CACB5.2010609@ichips.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 13:58:32 -0800
In-Reply-To: <440CACB5.2010609@ichips.intel.com> (Sean Hefty's message of "Mon, 06 Mar 2006 13:42:13 -0800")
Message-ID: <adabqwj5j7b.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Mar 2006 21:58:33.0964 (UTC) FILETIME=[1CF222C0:01C64169]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Sean> Unless I miss counted, they should be aligned.
    Sean> ib_user_path_rec is defined near the end of patch 1/6.

You're right.  struct sockaddr_in6 is 28 bytes long (not a multiple of
8) but gcc seems to lay everything out the same on 32-bit and 64-bit
architectures just the same.

 - R.
