Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWEIUqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWEIUqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWEIUqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:46:55 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:57504 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751168AbWEIUqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:46:54 -0400
X-IronPort-AV: i="4.05,107,1146466800"; 
   d="scan'208"; a="1803285523:sNHT1256752042"
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Stephen Hemminger <shemminger@osdl.org>, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       netdev@vger.kernel.org
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
X-Message-Flag: Warning: May contain useful information
References: <20060509084945.373541000@sous-sol.org>
	<20060509085201.446830000@sous-sol.org>
	<20060509132556.76deaa91@localhost.localdomain>
	<6a1855ab01a195ac2a28a97c5f966f67@cl.cam.ac.uk>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 09 May 2006 13:46:47 -0700
In-Reply-To: <6a1855ab01a195ac2a28a97c5f966f67@cl.cam.ac.uk> (Keir Fraser's message of "Tue, 9 May 2006 21:26:11 +0100")
Message-ID: <ada1wv3apu0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 May 2006 20:46:48.0557 (UTC) FILETIME=[B12929D0:01C673A9]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Keir> Where should we get our entropy from in a VM environment?
    Keir> Leaving the pool empty can cause processes to hang.

You could have something like a virtual HW RNG driver (with a frontend
and backend), which steals from the dom0 /dev/random pool.

 - R.
