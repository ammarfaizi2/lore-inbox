Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753444AbWKFQux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbWKFQux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbWKFQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:50:53 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:14653 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1753444AbWKFQuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:50:52 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CANL1TkWrRApR/2dsb2JhbAA
X-IronPort-AV: i="4.09,392,1157353200"; 
   d="scan'208"; a="1862299288:sNHT37368214"
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
       rolandd@cisco.com, raisch@de.ibm.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control block in 64k page mode
X-Message-Flag: Warning: May contain useful information
References: <200611052140.38445.hnguyen@de.ibm.com>
	<200611060045.59074.arnd@arndb.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Nov 2006 08:50:44 -0800
In-Reply-To: <200611060045.59074.arnd@arndb.de> (Arnd Bergmann's message of "Mon, 6 Nov 2006 00:45:58 +0100")
Message-ID: <adaslgwo6xn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Nov 2006 16:50:44.0726 (UTC) FILETIME=[B3A0D160:01C701C3]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I'd simply move the memset into the alloc function and get rid of the
 > constructor here.

Slightly better still would be to use kmem_cache_zalloc() (save a tiny
bit of text by getting rid of the call to memset).

 - R.
