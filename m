Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283051AbRK1OTa>; Wed, 28 Nov 2001 09:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282147AbRK1OTW>; Wed, 28 Nov 2001 09:19:22 -0500
Received: from imailg1.svr.pol.co.uk ([195.92.195.179]:22367 "EHLO
	imailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S283051AbRK1OTM>; Wed, 28 Nov 2001 09:19:12 -0500
Message-ID: <3C04F247.8080400@humboldt.co.uk>
Date: Wed, 28 Nov 2001 14:18:47 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: bttv module intialization takes much time on kernel-2.4.x
In-Reply-To: <200111231654.fANGs0705731@rai.sytes.net> <slrn9vt1qe.8en.kraxel@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:


> RTFM?
> 
> Documentation/video4linux/bttv/README says:
> 
> If bttv takes very long to load (happens sometimes with the cheap
> cards which have no tuner), try adding this to your modules.conf:
>         options i2c-algo-bit bit_test=1


This is a nuisance on embedded systems which don't use modules, and 
which don't have tuners. I've ended up maintaining a local patch to 
force this on. It affects every user of i2c-algo-bit, but nothing else 
on this particular board suffers as a consequence.

What might be useful would be a config option to build bttv without 
tuners and i2c to reduce code size and sidestep this problem. Would you 
take a patch that did that?


-- 
Adrian Cox   http://www.humboldt.co.uk/

