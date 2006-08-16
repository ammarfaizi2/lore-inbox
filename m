Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWHPQPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWHPQPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWHPQPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:15:20 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:23660 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751096AbWHPQPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:15:18 -0400
X-IronPort-AV: i="4.08,133,1154934000"; 
   d="scan'208"; a="336576238:sNHT29287832"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Trivial kzalloc opportunity
X-Message-Flag: Warning: May contain useful information
References: <1155745728.24077.354.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 16 Aug 2006 09:15:15 -0700
In-Reply-To: <1155745728.24077.354.camel@localhost.localdomain> (Alan Cox's message of "Wed, 16 Aug 2006 17:28:48 +0100")
Message-ID: <aday7toejxo.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Aug 2006 16:15:16.0776 (UTC) FILETIME=[2965EA80:01C6C14F]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +	return (struct tty_struct *)kzalloc(sizeof(struct tty_struct), GFP_KERNEL);

Why the cast here?  kzalloc() returns void *

 - R.
