Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWALBcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWALBcI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWALBcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:32:08 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:19218 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S964952AbWALBcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:32:06 -0500
X-IronPort-AV: i="3.99,357,1131350400"; 
   d="scan'208"; a="390710048:sNHT38039156"
To: Andi Kleen <ak@suse.de>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
X-Message-Flag: Warning: May contain useful information
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com>
	<200601120156.11529.ak@suse.de> <adaace2i6lr.fsf@cisco.com>
	<200601120227.45209.ak@suse.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 11 Jan 2006 17:32:03 -0800
In-Reply-To: <200601120227.45209.ak@suse.de> (Andi Kleen's message of "Thu,
 12 Jan 2006 02:27:44 +0100")
Message-ID: <ada64oqi63w.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 12 Jan 2006 01:32:05.0592 (UTC) FILETIME=[FEF6ED80:01C61717]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> Well then they can just as well use normal memcpy as long as
    Andi> they don't pass any sizes % 4 != 0. That should be ok as
    Andi> long as they add a comment there.

But then the driver will be doing memcpy() to I/O memory, which may
work by chance on x86_64 but will blow up on other archs.

 - R.
