Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751987AbWCFTbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbWCFTbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWCFTbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:31:11 -0500
Received: from fmr18.intel.com ([134.134.136.17]:8374 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751164AbWCFTbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:31:10 -0500
Message-ID: <440C8DFB.7090005@ichips.intel.com>
Date: Mon, 06 Mar 2006 11:31:07 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Caitlin Bestler <caitlinb@broadcom.com>
CC: Sean Hefty <sean.hefty@intel.com>, Roland Dreier <rdreier@cisco.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] RE: [PATCH 2/6] IB: match connection requests
 based on private data
References: <54AD0F12E08D1541B826BE97C98F99F12FBF19@NT-SJCA-0751.brcm.ad.broadcom.com>
In-Reply-To: <54AD0F12E08D1541B826BE97C98F99F12FBF19@NT-SJCA-0751.brcm.ad.broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Caitlin Bestler wrote:
> The term "private data" is intended to convey the
> intent that the data is private to the application
> layer and is opaque to middleware and the network.

The private data area is for the use of whatever client resides above the 
Infiniband CM only.  There is no assumption about whether that client is 
middleware or an application.

> By what mechanism does the listening application
> delegate how much of the private data for use by
> the CM for sub-dividing a listen? What does an 
> application do if it wishes to retain full ownership
> of the private data?

An application that interfaces directly with the Infiniband CM always retains 
full control of any private data.  Applications that interface to middleware are 
restricted by the limitations of that middleware layer.

- Sean
