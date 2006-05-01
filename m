Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWEAVlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWEAVlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWEAVlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:41:44 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:51018 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932275AbWEAVln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:41:43 -0400
X-IronPort-AV: i="4.05,77,1146466800"; 
   d="scan'208"; a="1800327999:sNHT30900044"
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2 of 13] ipath - set up 32-bit DMA mask if 64-bit setup fails
X-Message-Flag: Warning: May contain useful information
References: <1906950392f7ef8c7d07.1145913778@eng-12.pathscale.com>
	<ada7j55vayj.fsf@cisco.com>
	<4B05D10C-407E-46A5-848F-0897D1E6D1CD@kernel.crashing.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 14:41:39 -0700
In-Reply-To: <4B05D10C-407E-46A5-848F-0897D1E6D1CD@kernel.crashing.org> (Segher Boessenkool's message of "Mon, 1 May 2006 21:56:09 +0200")
Message-ID: <adapsixs9rg.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 May 2006 21:41:41.0385 (UTC) FILETIME=[0888D790:01C66D68]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Segher> PowerPC with U3 or U4 northbridge, i.e. Maple or PowerMac
    Segher> G5 systems.  If the IOMMU (DART) is disabled, we have a
    Segher> 32-bit only DMA mask.  The DART will be disabled by
    Segher> default if there is 2GB or less of memory (as it isn't
    Segher> needed then).

OK, thanks.  I was not aware of that situation.

However, I suspect that PathScale has a different situation in mind,
considering that their driver isn't even buildable for that platform ;)

 - R.
