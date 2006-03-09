Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWCIXvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWCIXvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWCIXvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:51:38 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:34585 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1752089AbWCIXvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:51:37 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	<adad5gvfbhe.fsf@cisco.com>
	<1141948189.10693.48.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:51:34 -0800
In-Reply-To: <1141948189.10693.48.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Thu, 09 Mar 2006 15:49:49 -0800")
Message-ID: <adaek1bdvnd.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:51:35.0696 (UTC) FILETIME=[66699100:01C643D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Yep, this is a real race, albeit incredibly unlikely.  I
    Bryan> just turned ipath_sma_alive into an atomic_t, and wrapped
    Bryan> the open/close code in spinlocks.

How does making it an atomic_t help?  I think you're only going to be
using atomic_set() and atomic_read(), and atomic_t doesn't provide
anything in that case.

 - R.
