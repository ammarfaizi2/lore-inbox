Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUIIR4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUIIR4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUIIRl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:41:58 -0400
Received: from imr2.ericy.com ([198.24.6.3]:27290 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S266534AbUIIRkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:40:13 -0400
Message-ID: <41409378.5060908@ericsson.com>
Date: Thu, 09 Sep 2004 13:31:36 -0400
From: Makan Pourzandi <Makan.Pourzandi@ericsson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication
 of binaries
References: <41407CF6.2020808@ericsson.com> <20040909092457.L1973@build.pdx.osdl.net>
In-Reply-To: <20040909092457.L1973@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Chris Wright wrote:
> * Makan Pourzandi (Makan.Pourzandi@ericsson.com) wrote:
>>
>>DSI development team would like to announce the release 1.3.1 of digsig.
...
>>
>>Changes from Digsig release 0.2 announced in this mailing list:
>>================================================================
>>
>>     - the verification of signatures for the shared binaries has been
>>     added.
>>     - added support for caching of signatures
>>     - added documentation for digsig
>>     - added support for revoked signatures
>>     - support to avoid vulnerability for rewrite of shared
>>     libraries
> 
> 
> Could you elaborate on this one?

We realized that when a shared library is opened by a binary it can 
still be modified. To solve the problem, we block the write access to 
the shared binary while it is loaded.

> 
> 
>>     - use sysfs to connect to the module instead of the char device
>>     - code clean up, and some bug fixes
>>
>>Future works
>>=============
>>
>>     - improving the caching and revocation: it is currently tested
>>       and will be sent out soon after stability testing
> 
> 
> Should be helpful enough to cache result until thing's opened for
> writing, or is that what you're doing now?
> 

This is what we're doing now, but we need to implement a hash table to 
accelerate the lookup for the signatures.

Regards,
Makan

> thanks,
> -chris

-- 

Makan Pourzandi, Open Systems Lab
Ericsson Research, Montreal, Canada
*This email does not represent or express the opinions of Ericsson Inc.*

