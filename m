Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVCBJiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVCBJiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 04:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVCBJiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 04:38:08 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:22583
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S262243AbVCBJiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:38:03 -0500
Message-ID: <42258974.4080104@ev-en.org>
Date: Wed, 02 Mar 2005 09:37:56 +0000
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Dickson <paul@permanentmail.com>
Cc: dickson@permanentmail.com, linux-os@analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Network speed Linux-2.6.10
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com>	<20050301175143.04cbbe64.dickson@permanentmail.com>	<422510BA.1010305@ev-en.org> <20050301202400.36259d94.paul@permanentmail.com>
In-Reply-To: <20050301202400.36259d94.paul@permanentmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Dickson wrote:
> On Wed, 02 Mar 2005 01:02:50 +0000, Baruch Even wrote:
> 
>>>Might this be related to the broken BicTCP implementations in the 2.6.6+
>>>kernels?  A fix was added around 2.6.11-rc3 or 4.
>>
>>Unlikely, the problem with BIC would have shown itself only at high 
>>speeds over long latency links, not over a lan connection.
> 
> I only mentioned the possibility because I saw the same profile given by
> the PDF (the link was mentioned in the patch) while downloading gnoppix
> via my cable modem.  The oscillations of speed varied from 40K to 500+K.
> The average ended up around 270K.  (I was using wget for the download).

If it is indeed BIC than we have a bug where it doesn't shut itself off 
for low latencies. Since we don't test this case extensively here (we 
work to improve high-speed and just make sure we don't ruin slower 
speeds) I can't say it's impossible, try turning BIC off and see if it 
helps.

Due to the scenario that the OP gave it is more likely something to do 
with auto-detection somewhere along the way or a driver bug. It is also 
possible that I'm mistaken and it is BIC, never hurts to check.

Baruch
